import Foundation

/// Persistent cart storage for iOS 15 and 16. Reads are throwing so corrupt data
/// cannot be mistaken for an empty cart and overwritten by the next insert.
@MainActor
final class LegacyExamCartStore {
    private let defaults: UserDefaults
    private let storageKey: String

    init(defaults: UserDefaults = .standard, storageKey: String = "examCart.items.v1") {
        self.defaults = defaults
        self.storageKey = storageKey
    }

    func insertExams(_ exams: [CartExam]) throws {
        var stored = try getExams()
        for exam in exams {
            if let index = stored.firstIndex(where: { $0.examId == exam.examId }) {
                stored[index] = exam
            } else {
                stored.append(exam)
            }
        }
        try save(stored)
    }

    func deleteExams() throws {
        defaults.removeObject(forKey: storageKey)
    }

    func deleteExam(examId: String) throws {
        try save(getExams().filter { $0.examId != examId })
    }

    func getExams() throws -> [CartExam] {
        guard let data = defaults.data(forKey: storageKey) else { return [] }
        return try JSONDecoder().decode([CartExam].self, from: data)
    }

    func getExam(examId: String) throws -> CartExam? {
        try getExams().first { $0.examId == examId }
    }

    private func save(_ exams: [CartExam]) throws {
        defaults.set(try JSONEncoder().encode(exams), forKey: storageKey)
    }
}
