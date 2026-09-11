//
//  ArrayExtension.swift
//  Q and A
//
//  Created by GIGL-PC on 08/09/2026.
//

import Foundation


extension Array where Element == ExamPay {
    var isPriceTheSame: Bool {
        guard let firstPrice = first?.exam.price else {
            return false
        }

        return allSatisfy { $0.exam.price == firstPrice }
    }
}
