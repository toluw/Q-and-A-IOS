//
//  AppUtils.swift
//  Q and A
//
//  Created by GIGL-PC on 08/04/2026.
//

import Foundation
import SwiftUI


func showErrorMessage(message: String, actionTitle: String, showCancel: Bool = true, action: @escaping () -> Void){
    BottomSheetManager.shared.show(
        BottomSheetData(
            type: .error,
            message: message,
            actionTitle: actionTitle,
            showCancel: showCancel,
            action: action
            
        )
    )
}


func showSuccessMessage(message: String, actionTitle: String, showCancel: Bool = true, action: @escaping () -> Void){
    BottomSheetManager.shared.show(
        BottomSheetData(
            type: .success,
            message: message,
            actionTitle: actionTitle,
            showCancel: showCancel,
            action: action
            
        )
    )
}


func showNoticeMessage(message: String, actionTitle: String, showCancel: Bool = true, action: @escaping () -> Void){
    BottomSheetManager.shared.show(
        BottomSheetData(
            type: .notice,
            message: message,
            actionTitle: actionTitle,
            showCancel: showCancel,
            action: action
            
        )
    )
}

extension Dictionary where Value == Any {
    mutating func addOptional(key: Key, value: Any?) {
        if let value = value {
            self[key] = value
        }
    }
}


extension Binding {
    func unwrap<Wrapped>() -> Binding<Wrapped>? where Value == Wrapped? {
        guard wrappedValue != nil else { return nil }

        return Binding<Wrapped>(
            get: { wrappedValue! },
            set: { wrappedValue = $0 }
        )
    }
}


@MainActor func openPDF(
    remoteURL: URL,
    navVM: MainNavViewModel
) {

    if let cached =
        PDFRepository().cachedFile(for: remoteURL) {
        
        navVM.navigate(route: .pdfReaderScreen(fileUrl: cached))

        
    } else {
        
        navVM.navigate(route: .pdfLoaderScreen(remoteURL: remoteURL))

        

    }

}
