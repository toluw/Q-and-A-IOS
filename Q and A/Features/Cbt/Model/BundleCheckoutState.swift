//
//  BundleCheckoutState.swift
//  Q and A
//
//  Created by GIGL-PC on 16/10/2026.
//

import Foundation

struct BundleCheckoutState{
    
    var hasAppliedCode = false
    var originalPrice: String = ""
    var bundlePrice: String = ""
    var referralDiscount: String = ""
    var total: String = ""
    var bundleSavingsLabel: String = ""
    var paymentText: String = ""
    var errorMessage: String? = nil
    var showBlockedLoader: Bool = false
    var totalPrice: BundlePrice? = nil
    var agent: Agent? = nil
   
    
}
