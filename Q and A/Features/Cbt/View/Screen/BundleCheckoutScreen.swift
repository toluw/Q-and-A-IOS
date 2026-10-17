//
//  BundleCheckoutScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 16/10/2026.
//

import SwiftUI

struct BundleCheckoutScreen: View {
    
    @ObservedObject var cbtViewModel: CbtViewModel
    @StateObject var viewModel: BundleCheckoutViewModel = .init()
    @ObservedObject var navVm: MainNavViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear{
                viewModel.setTotalPrice(bundles: cbtViewModel.selectedBundles)
                viewModel.updateViews()
            }
            .onChange(of: viewModel.state.inputtedCode){prev, current in
                viewModel.onTextInputChanged(text: current)
            }
    }
    
    
    func pay(){
        cbtViewModel.agent = viewModel.state.agent
        navVm.replaceTop(route: .bundlePaymentScreen)
        
        
    }

    
}


#Preview {
    BundleCheckoutScreen(cbtViewModel: CbtViewModel(), navVm: MainNavViewModel())
}
