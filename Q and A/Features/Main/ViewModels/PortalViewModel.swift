import Foundation

@MainActor
class PortalViewModel: ObservableObject {
    @Published var state: PortalState

    private let service: MainServiceProtocol

    init(service: MainServiceProtocol = MainService(), state: PortalState = PortalState()) {
        self.service = service
        self.state = state
    }

    func loadInitial() async {
        guard state.data == nil, state.errorMessage == nil else { return }
        await getPortalData()
    }
    
    
    func showPortaBottomSheet(items: [PortalItem], title: String){
        state.portalItems = items
        state.sheetTitle = title
        state.showBottomSheet = true
    }

    func getPortalData() async {
        guard !state.isLoading else { return }
        state.isLoading = true
        state.errorMessage = nil
        defer { state.isLoading = false }

        do {
            let response = try await service.getPortalData(email: UserSettings.email ?? "")
            try Task.checkCancellation()
            guard response.status else {
                throw AppError.server(response.message)
            }
            guard let data = response.data else {
                throw AppError.decoding
            }
            state.data = data
        } catch is CancellationError {
            // A later screen appearance can retry a cancelled initial request.
        } catch {
            state.errorMessage = error.localizedDescription
        }
    }
}
