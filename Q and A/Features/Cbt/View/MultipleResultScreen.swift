//
//  MultipleResultScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 07/06/2026.
//

import SwiftUI

struct MultipleResultScreen: View {
    
    
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MultipleResultScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())
}
