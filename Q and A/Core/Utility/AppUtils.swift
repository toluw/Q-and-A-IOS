//
//  AppUtils.swift
//  Q and A
//
//  Created by GIGL-PC on 08/04/2026.
//

import Foundation


func showErrorMessage(message: String, actionTitle: String, action: @escaping () -> Void){
    BottomSheetManager.shared.show(
        BottomSheetData(
            type: .error,
            message: message,
            actionTitle: actionTitle,
            action: action
            
        )
    )
}


func showSuccessMessage(message: String, actionTitle: String, action: @escaping () -> Void){
    BottomSheetManager.shared.show(
        BottomSheetData(
            type: .success,
            message: message,
            actionTitle: actionTitle,
            action: action
            
        )
    )
}
