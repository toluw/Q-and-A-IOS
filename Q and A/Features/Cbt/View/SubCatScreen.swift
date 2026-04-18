//
//  SubCatScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 17/04/2026.
//

import SwiftUI

struct SubCatScreen: View {
    
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    
    var body: some View {
        Text("Objective SubCAt")
    }
}

#Preview {
    SubCatScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())
}
