//
//  PaymentState.swift
//  Q and A
//
//  Created by GIGL-PC on 14/05/2026.
//

import Foundation


enum PaymentState{
    
    case initialize
    case success(reference: String)
    case cancel
    
}
