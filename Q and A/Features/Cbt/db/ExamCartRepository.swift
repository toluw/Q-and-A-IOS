//
//  ExamCartRepository.swift
//  Q and A
//
//  Created by GIGL-PC on 09/05/2026.
//

import Foundation
import SwiftData

final class ExamCartRepository{
    
    
    private let context: ModelContext

        init(context: ModelContext) {
            self.context = context
        }

        // INSERT EXAMS
        func insertExams(_ exams: [ExamCart]) throws {
            for exam in exams {
                context.insert(exam)
            }

            try context.save()
        }

        // DELETE ALL EXAMS
        func deleteExams() throws {

            let descriptor = FetchDescriptor<ExamCart>()
            let exams = try context.fetch(descriptor)

            for exam in exams {
                context.delete(exam)
            }

            try context.save()
        }

        // DELETE SINGLE EXAM
        func deleteExam(examId: String) throws {

            let descriptor = FetchDescriptor<ExamCart>(
                predicate: #Predicate { $0.examId == examId }
            )

            let exams = try context.fetch(descriptor)

            for exam in exams {
                context.delete(exam)
            }

            try context.save()
        }

        // GET ALL EXAMS
        func getExams() throws -> [ExamCart] {

            let descriptor = FetchDescriptor<ExamCart>()

            return try context.fetch(descriptor)
        }

        // GET SINGLE EXAM
        func getExam(examId: String) throws -> ExamCart? {

            let descriptor = FetchDescriptor<ExamCart>(
                predicate: #Predicate { $0.examId == examId }
            )

            return try context.fetch(descriptor).first
        }
}
