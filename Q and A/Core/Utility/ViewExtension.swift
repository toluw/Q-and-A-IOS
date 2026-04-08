//
//  ViewExtension.swift
//  Q and A
//
//  Created by GIGL-PC on 05/04/2026.
//

import Foundation

import SwiftUI

extension View {
    func toastBanner(toast: Binding<ToastData?>) -> some View {
        self.modifier(ToastBannerModifier(toast: toast))
    }
    
    func globalBottomSheet() -> some View {
            self.modifier(GlobalBottomSheetModifier())
    }
}
