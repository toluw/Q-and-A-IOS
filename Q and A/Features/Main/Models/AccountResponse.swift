import Foundation

struct AccountResponse: Decodable {
    let status: Bool
    let message: String
    let data: AccountDetails?
}

struct AccountDetails: Decodable {
    let accountName: String?
    let accountNumber: String?
    let bank: String?
    let accountType: String?
}

struct SetAccountBody: Encodable {
    let accountName: String
    let accountNumber: String
    let accountType: String
    let bank: String
    let email: String
}

enum BankAccountType: String, CaseIterable {
    case savings = "Savings"
    case current = "Current"
}
