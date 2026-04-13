//
//  BaseCat.swift
//  Q and A
//
//  Created by GIGL-PC on 13/04/2026.
//

import Foundation


struct BaseCat: Identifiable{
    let id: String = UUID().uuidString
    let data: DataModel
    let image: String
    let background: String
    
}
