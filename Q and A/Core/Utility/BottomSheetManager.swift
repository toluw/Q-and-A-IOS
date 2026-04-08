//
//  BottomSheetManager.swift
//  Q and A
//
//  Created by GIGL-PC on 08/04/2026.
//

import Foundation
import SwiftUI

final class BottomSheetManager: ObservableObject {
    
    static let shared = BottomSheetManager()
    
    @Published var sheet: BottomSheetData? = nil
    
    private init() {}
    
    func show(_ data: BottomSheetData) {
        DispatchQueue.main.async {
            withAnimation {
                self.sheet = data
            }
        }
    }
    
    func dismiss() {
        withAnimation {
            sheet = nil
        }
    }
}
