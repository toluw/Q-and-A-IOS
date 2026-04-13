//
//  AppUtils.swift
//  Q and A
//
//  Created by GIGL-PC on 08/04/2026.
//

import Foundation


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
