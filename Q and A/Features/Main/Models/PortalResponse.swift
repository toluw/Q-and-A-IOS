import Foundation

struct PortalResponse: Codable {
    let status: Bool
    let message: String
    let data: PortalData?
}

struct PortalData: Codable {
    let is_agent: Bool
    let is_cbt_seller: Bool
    let agent_code: String?
    let is_agent_active: Bool
}
