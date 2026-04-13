//
//  MainCbtScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 24/03/2026.
//

import SwiftUI

struct MainCbtScreen: View {
    
    let onShowNavDrawer: () -> Void
    @StateObject var viewModel: MainCbtViewModel = .init()
    
    let columns = [
            GridItem(.flexible(), spacing: 20),
            GridItem(.flexible(), spacing: 20)
        ]
    
    var body: some View {
        
        VStack{
            
            HStack(){
                
                Button(){
                    
                }label: {
                    Image("hamburger")
                }
                
                TextField("Search CBT..", text: .constant(""))
                    .padding(.leading,16)
                    .padding(.trailing,16)
                    .textFieldStyle(.roundedBorder)
                    
                
                Button(){
                    
                }label: {
                    Image("info")
                }
                
                Button(){
                    
                    
                }label: {
                    Image("cart")
                }.padding(.leading, 8)
                
            }.frame(maxWidth: .infinity)
             .padding(.leading, 16)
             .padding(.trailing, 16)
            
            
            ZStack(){
                
                if(viewModel.state.isLoading){
                   
                    ProgressView()
                    
                }else{
                    if(viewModel.state.errorMessage != nil){
                        
                        ErrorView(message: viewModel.state.errorMessage!){
                            viewModel.loadData()
                        }
                       
                    }else{
                       
                        VStack{
                            
                            Spacer().frame(height: 35)
                            
                            
                                LazyVGrid(columns: columns, spacing: 20){
                                    ForEach(viewModel.state.items){item in
                                        MainCbtItemView(item: item){
                                            
                                        }
                                    }
                                }.padding(.leading, 16)
                                 .padding(.trailing, 16)
                                
                            
                            
                            Spacer()
                            
                            
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        
                        
                    }
                }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear{
                    viewModel.loadData()
                }
            
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}

#Preview {
    MainCbtScreen(onShowNavDrawer: {})
}
