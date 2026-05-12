//
//  CartView.swift
//  Q and A
//
//  Created by GIGL-PC on 18/04/2026.
//

import SwiftUI

struct CartView: View {
    
    let onCartClicked: () -> Void
    
    @State var numCart: Int = 0
    
    @Environment(\.modelContext) private var context

    private var repository: ExamCartRepository {
        ExamCartRepository(context: context)
        }
    
    var body: some View {
        Button(){
            onCartClicked()
        }label: {
            
            ZStack(alignment:.bottomTrailing){
              
                Image("cart")
                
                if(numCart > 0){
                  
                    Circle()
                        .fill(Color("SecColor"))
                        .frame(width: 12, height: 12)
                        .overlay{
                            Text(String(numCart))
                                .font(AppFont.medium(8))
                                .foregroundColor(.white)
                        }
                        .offset(x: 6, y: -16)
                    
                    
                }
                
                
                    
            
            }
            
            
        }.onAppear{
            
            let exams = try? repository.getExams()
            
            numCart = exams?.count ?? 0
            
        }

    }
}

#Preview {
    CartView(onCartClicked: {})
}
