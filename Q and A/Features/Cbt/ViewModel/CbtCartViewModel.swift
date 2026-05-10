//
//  CbtCartViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 10/05/2026.
//

import Foundation

@MainActor
class CbtCartViewModel: ObservableObject{
    
    @Published var state: cbtCartState = cbtCartState()
    
    
    
    func initCartItems(cartItems: [ExamCart]){
        state.cartItems = cartItems
    }
    
    
    
    func deleteCartItem(position: Int){
        
        state.cartItems.remove(at: position)
        
    }
    
    func getExamPay() -> [ExamPay]{
        
    
        var items: [ExamPay] = []
        
        for examCart in state.cartItems{
            
            items.append(ExamPay(exam: examCart.toExam()))
        }
        
        return items
    }
    
    
    func setTotalPrice(){
        
        var totalPrice = 0
        
        for examCart in state.cartItems{
            
            totalPrice += examCart.price
            
        }
        
        state.totalPrice = totalPrice
        
    }
    
    
}

