import Foundation

struct EarningsCbtState {
    var income: Decimal = 0
    var statements: [EarningsCbtStatement] = []
    var isLoading = false
    var hasLoaded = false
    var errorMessage: String?

    var isEmpty: Bool { hasLoaded && statements.isEmpty && errorMessage == nil }

    var days: [EarningsCbtDay] {
        Dictionary(grouping: statements, by: \.day)
            .map { EarningsCbtDay(id: $0.key, statements: $0.value.sorted { $0.created_at > $1.created_at }) }
            .sorted { $0.id > $1.id }
    }
}
