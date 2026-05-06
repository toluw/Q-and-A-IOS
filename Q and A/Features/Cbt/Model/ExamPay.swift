//
//  ExamPay.swift
//  Q and A
//
//  Created by GIGL-PC on 05/05/2026.
//

import Foundation

struct ExamPay: Equatable, Identifiable{
    var id: UUID = UUID()
    var exam: Exam
    var isSelected: Bool = false
}
