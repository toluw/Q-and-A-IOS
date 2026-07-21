//
//  NumPostResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 18/07/2026.
//

import Foundation


struct NumPostResponse: Codable{
    let data: NumPostData
    let status: Bool
    let message: String
}


struct NumPostData: Codable{
    let num_post: Int
}
