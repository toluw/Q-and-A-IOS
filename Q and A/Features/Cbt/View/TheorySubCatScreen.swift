//
//  TheorySubCatScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 17/04/2026.
//

import SwiftUI

struct TheorySubCatScreen: View {
    
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TheorySubCatScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())
}
