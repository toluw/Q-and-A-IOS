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
        if(!cbtViewModel.examResultDataList.isEmpty){
            MultipleResultView(results: cbtViewModel.examResultDataList, navVm: navVm, cbtViewModel: cbtViewModel)
        }
    }
}

#Preview {
    MultipleResultScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())
}
