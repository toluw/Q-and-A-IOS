//
//  ExamSubCatScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 14/04/2026.
//

import SwiftUI

struct ExamSubCatScreen: View {
    
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    @ObservedObject var paymentViewModel: PaymentViewModel
    
    
    var body: some View {
        VStack{
            
           
            ZStack{
                if(cbtViewModel.parentCategoriesData?.catData?.hasObjective == true  && cbtViewModel.parentCategoriesData?.catData?.hasTheory == true){
                    
                    TabSubCatScreen(navVm: navVm, cbtViewModel: cbtViewModel, paymentViewModel: paymentViewModel)
                }else{
                    if(cbtViewModel.parentCategoriesData?.catData?.hasObjective == true){
                        SubCatScreen(navVm: navVm, cbtViewModel: cbtViewModel, paymentViewModel: paymentViewModel)
                    }else if(cbtViewModel.parentCategoriesData?.catData?.hasTheory == true){
                        TheorySubCatScreen(navVm: navVm, cbtViewModel: cbtViewModel)
                    }
                }
            }
            
            Spacer()
        
            
            
            
        }
        .toolbar {
            
            // Title
            ToolbarItem(placement: .principal) {
                Text(cbtViewModel.parentCategoriesData?.item ?? "Subjects").font(AppFont.regular(18))
            }
            
            // Trailing Icon
            ToolbarItem(placement: .navigationBarTrailing) {
                CartView(){
                    navVm.navigate(route: .cbtCartScreen)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .toolbarBackground(.white, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    ExamSubCatScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel(), paymentViewModel: PaymentViewModel())
}
