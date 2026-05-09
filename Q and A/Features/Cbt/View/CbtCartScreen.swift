//
//  CbtCartScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 09/05/2026.
//

import SwiftUI

struct CbtCartScreen: View {
    
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CbtCartScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())
}
