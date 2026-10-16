//
//  BundleBottomSheetView.swift
//  Q and A
//
//  Created by GIGL-PC on 16/10/2026.
//

import SwiftUI

struct BundleBottomSheetView: View {
    
    let offer: Offer
    let bundleId: String?
    
    @StateObject var viewModel: BundleViewModel = .init()
    
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    BundleBottomSheetView(offer: Offer(offerId: "2", offerType: "Subject", hasOffer: true, cbcId: "1", level: "2", title: "Waec"), bundleId: nil)
}
