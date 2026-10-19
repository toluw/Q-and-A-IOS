import Foundation

@MainActor
final class EarningsCbtViewModel: ObservableObject {
    @Published private(set) var state = EarningsCbtState()
    private let service: MainServiceProtocol

    init(service: MainServiceProtocol = MainService()) {
        self.service = service
    }

    func loadInitial() async {
        guard !state.hasLoaded else { return }
        await refresh()
    }

    func refresh() async {
        guard !state.isLoading else { return }
        state.isLoading = true
        state.errorMessage = nil
        defer { state.isLoading = false }

        guard let email = UserSettings.email, !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            state.errorMessage = "Please sign in to view your earnings."
            return
        }

        do {
            let response = try await service.getIncome(email: email)
            try Task.checkCancellation()
            guard response.status else {
                throw AppError.server(response.message.isEmpty ? "Unable to load earnings." : response.message)
            }
            guard let data = response.data else {
                throw AppError.server("The server returned no earnings data. Please try again.")
            }
            state.income = data.income
            state.statements = data.statement
            state.hasLoaded = true
        } catch is CancellationError {
            // Allow a subsequent appearance to retry a cancelled initial request.
        } catch {
            state.errorMessage = error.localizedDescription
        }
    }
}
