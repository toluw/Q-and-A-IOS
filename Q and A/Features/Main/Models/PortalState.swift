import Foundation

enum PortalAgentState: Equatable {
    case none
    case active(code: String)
    case inactive(code: String)
}

struct PortalState {
    var data: PortalData? = nil
    var isLoading = false
    var errorMessage: String? = nil
    var showBottomSheet: Bool = false
    var portalItems: [PortalItem] = []
    var sheetTitle: String = ""
    var showBank: Bool = false

    var agentState: PortalAgentState {
        guard let data, data.is_agent else { return .none }
        let code = data.agent_code ?? ""
        return data.is_agent_active ? .active(code: code) : .inactive(code: code)
    }
}
