//
//  ProductLoadState.swift
//  Q and A
//
//  Created by GIGL-PC on 25/08/2026.
//

import Foundation
import StoreKit

enum ProductLoadState{
    
    case loading
    case loaded(Product)
    case error
    
}
