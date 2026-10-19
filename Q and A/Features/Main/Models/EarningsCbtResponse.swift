import Foundation

struct EarningsCbtResponse: Decodable {
    let status: Bool
    let message: String
    let data: EarningsCbtData?
}

struct EarningsCbtData: Decodable {
    let income: Decimal
    let statement: [EarningsCbtStatement]
}

struct EarningsCbtStatement: Decodable, Identifiable {
    let id: String
    let exam_id: String?
    let bundle_id: String?
    let buyer_email: String
    let seller_email: String
    let agent_email: String?
    let agent_income: String
    let income: String
    let reference: String
    let created_at: String
    let price: String
    let commision: String
    let is_android: String
    let bundle_discount: String
    let exam_name: String
    let buyer_name: String

    var day: String { String(created_at.prefix(10)) }
}

struct EarningsCbtDay: Identifiable {
    let id: String
    let statements: [EarningsCbtStatement]

    var title: String {
        let input = DateFormatter()
        input.locale = Locale(identifier: "en_US_POSIX")
        input.dateFormat = "yyyy-MM-dd"
        guard let date = input.date(from: id) else { return id }
        let output = DateFormatter()
        output.locale = Locale(identifier: "en_US")
        output.dateFormat = "MMM d, yyyy"
        return output.string(from: date)
    }
}

 enum EarningsCbtFormatting {
    static func amount(_ value: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_NG")
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSDecimalNumber(decimal: value)) ?? "0"
    }
}
