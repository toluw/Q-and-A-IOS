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
    @StateObject var viewModel: CbtCartViewModel = .init()
    
    @Environment(\.modelContext) private var context

    private var repository: ExamCartRepository {
        ExamCartRepository(context: context)
        }
    
    
    var body: some View {
        
        
        ZStack{
            
            if(viewModel.state.cartItems.isEmpty){
            
                VStack{
                    
                    Spacer()
                    
                    EmptyCartView(onContinueShopping: {
                        
                        navVm.pop()
                        
                    })
                    
                    Spacer()
                    
                    Spacer()
                    
                    
                }
                
                
            }else{
               
                VStack{
                    
                    ScrollView{
                        
                        LazyVStack{
                            
                            ForEach(viewModel.state.cartItems.indices, id: \.self) { index in
                                CartItemView(title: viewModel.state.cartItems[index].title,
                                             price: viewModel.state.cartItems[index].price,
                                             onDelete: {
                                     
                                    viewModel.deleteCartItem(position: index)
                                    
                                })
                            }
                            
                        }
                        
                    }
                    
                    Spacer()
                    
                    VStack{
                        
                        HStack{
                            
                            Text("Total")
                                .font(AppFont.medium(16))
                            
                            
                            Spacer()
                            
                            Text(viewModel.state.totalPrice, format: .currency(code: "NGN"))
                                .font(AppFont.bold(16))
                            
                        }.padding(.horizontal, 16)
                            .padding(.top, 12)
                        
                        
                        
                    PrimaryButton(buttonText: "Check Out", action: {
                        
                    })
                            .padding(.horizontal, 16)
                            .padding(.bottom, 12)
                        
                        
                        SecondaryButton(buttonText: "Continue Shopping", action: {
                            navVm.pop()
                        }) .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                          
                    
                        
                    }
                    
                    
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
                
            }
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear{
                
                let cartItems = try? repository.getExams()
                if let items = cartItems{
                    viewModel.initCartItems(cartItems: items)
                }
                
            }
            .onChange(of: viewModel.state.cartItems){previous, current in
                
                viewModel.setTotalPrice()
                
                
            }
        
        
       
    }
}

#Preview {
    CbtCartScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())
}
