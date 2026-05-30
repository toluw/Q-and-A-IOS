//
//  MainRoute.swift
//  Q and A
//
//  Created by GIGL-PC on 26/03/2026.
//

import Foundation

enum MainRoute: Hashable{
    
    case mainCommunityScreen
    case forgotPasswordScreen
    case confirmOtpScreen(otp: String, email: String)
    case changePassword(email: String)
    case parentCatScreen(title: String, cbcId: String, level: String, isMock: String)
    case examSubCatScreen
    case examCatScreen
    case mockDescriptionScreen
    case examDescriptionScreen
    case cbtPaymentScreen
    case examPracticeScreen
    case cbtCartScreen
    case examLoaderScreen
    case paystackPaymentScreen(authorizationUrl: String, accessCode: String, reference: String)
    case examSceen
    
}
