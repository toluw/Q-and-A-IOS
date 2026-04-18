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
        Text("Theory SubCat")
    }
}

#Preview {
    TheorySubCatScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())
}
