import Foundation

@MainActor
final class UpdateAccountViewModel: ObservableObject {
    @Published var accountName = ""
    @Published var accountNumber = ""
    @Published var accountType: BankAccountType?
    @Published var bank = ""
    @Published private(set) var isLoading = false
    @Published private(set) var isSaving = false
    @Published private(set) var hasLoaded = false
    @Published private(set) var loadError: String?
    @Published var errorMessage: String?
    @Published var successMessage: String?

    private let service: MainServiceProtocol
    private let emailProvider: () -> String?

    init(service: MainServiceProtocol = MainService(), emailProvider: @escaping () -> String? = { UserSettings.email }) {
        self.service = service
        self.emailProvider = emailProvider
    }

    func loadInitial() async {
        guard !hasLoaded, !isLoading else { return }
        isLoading = true
        loadError = nil
        defer { isLoading = false }
        do {
            let response = try await service.getAccount(email: signedInEmail())
            try Task.checkCancellation()
            guard response.status else { throw AppError.server(response.message) }
            guard let details = response.data else { throw AppError.decoding }
            accountName = details.accountName ?? ""
            accountNumber = details.accountNumber ?? ""
            bank = details.bank ?? ""
            accountType = BankAccountType.allCases.first {
                $0.rawValue.caseInsensitiveCompare(details.accountType ?? "") == .orderedSame
            }
            hasLoaded = true
        } catch is CancellationError {
            // Retry on the next appearance.
        } catch {
            loadError = error.localizedDescription
        }
    }

    func save() async {
        guard hasLoaded, !isSaving else { return }
        errorMessage = nil
        successMessage = nil
        let name = accountName.trimmingCharacters(in: .whitespacesAndNewlines)
        let number = accountNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty else { errorMessage = "Enter your account name."; return }
        guard number.count == 10, number.allSatisfy({ $0 >= "0" && $0 <= "9" }) else {
            errorMessage = "Enter a valid 10-digit account number."
            return
        }
        guard let accountType else { errorMessage = "Select an account type."; return }
        guard !bank.isEmpty else { errorMessage = "Select a bank."; return }
        isSaving = true
        defer { isSaving = false }
        do {
            let body = SetAccountBody(accountName: name, accountNumber: number, accountType: accountType.rawValue, bank: bank, email: try signedInEmail())
            let response = try await service.setAccount(body: body)
            guard response.status else { throw AppError.server(response.message) }
            accountName = name
            accountNumber = number
            successMessage = "Account details saved successfully."
        } catch is CancellationError {
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func signedInEmail() throws -> String {
        guard let email = emailProvider()?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty else {
            throw AppError.server("Please sign in to update your account details.")
        }
        return email
    }
}
