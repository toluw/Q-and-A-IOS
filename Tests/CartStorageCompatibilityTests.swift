// Standalone regression checks for the iOS 15/16 persistent cart backend.
import Foundation

@main
struct CartStorageCompatibilityTests {
    @MainActor
    static func main() throws {
        let suite = "CartStorageCompatibilityTests.\(UUID().uuidString)"
        let defaults = UserDefaults(suiteName: suite)!
        defer { defaults.removePersistentDomain(forName: suite) }
        let repository = LegacyExamCartStore(defaults: defaults)
        let first = item(id: "first", title: "Original", price: 100)
        let second = item(id: "second", title: "Second", price: 200)
        try expect(repository.getExams().isEmpty)
        try repository.insertExams([first, second])

        // A fresh repository reads the persisted cart, including all exam fields.
        let reopened = LegacyExamCartStore(defaults: defaults)
        let restored = try reopened.getExams()
        assert(restored.map { $0.toExam() } == [first.toExam(), second.toExam()])

        try reopened.insertExams([item(id: "first", title: "Updated", price: 350)])
        try expect(reopened.getExams().count == 2)
        try expect(reopened.getExam(examId: "first")?.price == 350)
        try reopened.deleteExam(examId: "first")
        try expect(reopened.getExam(examId: "first") == nil)
        try expect(reopened.getExams().map(\.examId) == ["second"])
        try reopened.deleteExams()
        try expect(repository.getExams().isEmpty)

        // A corrupt store surfaces a read error instead of silently losing data.
        defaults.set(Data("invalid cart".utf8), forKey: "examCart.items.v1")
        do {
            _ = try reopened.getExams()
            assertionFailure("Expected decoding error")
        } catch is DecodingError { }
        print("Cart storage compatibility checks passed")
    }

    static func expect(_ expression: @autoclosure () throws -> Bool) rethrows {
        let passed = try expression()
        assert(passed)
    }

    static func item(id: String, title: String, price: Int) -> CartExam {
        CartExam(cbtId: "cbt", subcatId: "subcat", numQuestions: 50,
                 price: price, title: title, instruction: "Instructions",
                 examDescription: "Description", duration: 3600, isActive: true,
                 createdAt: "2026-10-26", sellerEmail: "seller@example.com",
                 hasSample: true, examId: id, isProvisioned: false, numViews: 7,
                 isMaxAttempt: true, startTime: "09:00", isCompulsory: "1")
    }
}
