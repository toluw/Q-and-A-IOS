import Foundation

@MainActor
final class PaymentReceivedCbtViewModel: ObservableObject {
    @Published private(set) var state = PaymentReceivedCbtState()
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
            state.errorMessage = "Please sign in to view your payout history."
            return
        }

        do {
            let response = try await service.getCbtPayoutHistory(email: email)
            try Task.checkCancellation()
            guard response.status else {
                throw AppError.server(response.message.isEmpty ? "Unable to load payout history." : response.message)
            }
            guard let data = response.data else {
                throw AppError.server("The server returned no payout history data. Please try again.")
            }
            state.income = data.income ?? "0"
            state.payouts = data.payout.sorted { $0.created > $1.created }
            state.hasLoaded = true
        } catch is CancellationError {
            // Allow a subsequent appearance to retry a cancelled initial request.
        } catch {
            state.errorMessage = error.localizedDescription
        }
    }
}
