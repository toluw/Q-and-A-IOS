import Foundation
import SwiftData

/// Retains the existing SwiftData cart on iOS 17+, with a Codable store for
/// devices that cannot use SwiftData. Both stores upsert by exam ID.
@MainActor
final class ExamCartRepository {
    private let legacyStore: LegacyExamCartStore

    // Retain one container for the app lifetime, shared by every cart screen.
    @available(iOS 17.0, *)
    private static let container = Result {
        let container = try ModelContainer(for: ExamCart.self)
        // A device may upgrade from iOS 15/16 to iOS 17. Import its older cart
        // once, without replacing items already saved in the SwiftData store.
        let legacyStore = LegacyExamCartStore()
        let legacyItems = try legacyStore.getExams()
        if !legacyItems.isEmpty {
            let context = container.mainContext
            var storedIDs = Set(try context.fetch(FetchDescriptor<ExamCart>()).map(\.examId))
            for item in legacyItems where storedIDs.insert(item.examId).inserted {
                context.insert(ExamCart(item: item))
            }
            try context.save()
            try legacyStore.deleteExams()
        }
        return container
    }

    init() {
        legacyStore = LegacyExamCartStore()
    }

    func insertExams(_ exams: [CartExam]) throws {
        if #available(iOS 17.0, *) {
            let context = try Self.container.get().mainContext
            let stored = try context.fetch(FetchDescriptor<ExamCart>())
            for exam in exams {
                for existing in stored where existing.examId == exam.examId {
                    context.delete(existing)
                }
                context.insert(ExamCart(item: exam))
            }
            try context.save()
        } else {
            try legacyStore.insertExams(exams)
        }
    }

    func deleteExams() throws {
        if #available(iOS 17.0, *) {
            let context = try Self.container.get().mainContext
            for exam in try context.fetch(FetchDescriptor<ExamCart>()) {
                context.delete(exam)
            }
            try context.save()
        } else {
            try legacyStore.deleteExams()
        }
    }

    func deleteExam(examId: String) throws {
        if #available(iOS 17.0, *) {
            let context = try Self.container.get().mainContext
            let descriptor = FetchDescriptor<ExamCart>(predicate: #Predicate { $0.examId == examId })
            for exam in try context.fetch(descriptor) { context.delete(exam) }
            try context.save()
        } else {
            try legacyStore.deleteExam(examId: examId)
        }
    }

    func getExams() throws -> [CartExam] {
        if #available(iOS 17.0, *) {
            return try Self.container.get().mainContext.fetch(FetchDescriptor<ExamCart>()).map { $0.toCartExam() }
        }
        return try legacyStore.getExams()
    }

    func getExam(examId: String) throws -> CartExam? {
        try getExams().first { $0.examId == examId }
    }

}
