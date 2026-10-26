import Foundation

struct CbtPayoutHistoryResponse: Decodable {
    let status: Bool
    let message: String
    let data: CbtPayoutHistoryData?
}

struct CbtPayoutHistoryData: Decodable {
    let income: String?
    let payout: [CbtPayout]
}

struct CbtPayout: Decodable {
    let amount: String
    let created: String

    var formattedDate: String {
        let input = DateFormatter()
        input.locale = Locale(identifier: "en_US_POSIX")
        input.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = input.date(from: created) else { return created }
        let output = DateFormatter()
        output.locale = Locale(identifier: "en_US")
        output.dateFormat = "MMM d, yyyy"
        return output.string(from: date)
    }

    var formattedAmount: String {
        guard let value = Decimal(string: amount) else { return amount }
        return EarningsCbtFormatting.amount(value)
    }
}

struct PaymentReceivedCbtState {
    var income = "0"
    var payouts: [CbtPayout] = []
    var isLoading = false
    var hasLoaded = false
    var errorMessage: String?

    var isEmpty: Bool { hasLoaded && payouts.isEmpty && errorMessage == nil }
}
