//
//  GetCatExam.swift
//  Q and A
//
//  Created by GIGL-PC on 25/05/2026.
//

import Foundation

struct CatExamsResponse: Codable{
    let data: [Exam]
    let status: Bool
    let message: String
}
