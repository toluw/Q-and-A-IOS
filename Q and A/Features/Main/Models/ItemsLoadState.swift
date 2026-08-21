//
//  ItemsLoadState.swift
//  Q and A
//
//  Created by GIGL-PC on 21/08/2026.
//

import Foundation


enum ItemsLoadState {
    case loading
    case loaded([String])
    case empty
    case error(String)
}
