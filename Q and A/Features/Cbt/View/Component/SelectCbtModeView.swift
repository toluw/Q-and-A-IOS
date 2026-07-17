//
//  SelectCbtModeView.swift
//  Q and A
//
//  Created by GIGL-PC on 02/05/2026.
//

import SwiftUI

struct SelectCbtModeView: View {
    
    @State private var selectedMode: CbtMode? = nil
    let onModeSelected: (CbtMode) -> Void
    
    
    
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            Text("Select Mode")
                .font(AppFont.medium(18))
                .padding(.leading, 18)
                .padding(.top, 30)
                .padding(.bottom, 20)
            
            Rectangle().fill(Color("Grey")).frame(height: 1)
            
            Button(action: {
                selectedMode = .practice
            }){
                
                HStack{
                    
                    VStack(alignment: .leading){
                      
                        Text("Practice Mode")
                            .font(AppFont.semi_bold(16))
                            .padding(.bottom, 10)
                        
                        Text("This step-by-step mode allows you to review each question and answers in detail as you go through them")
                            .font(AppFont.regular(14))
                        
                        
                    }.padding(.vertical, 12)
                        .padding(.horizontal, 16)
                    
                    Spacer()
                    
                    ZStack{
                        if(selectedMode == .practice){
                            Image("set_check")
                        }else{
                            Image("set_uncheck")
                        }
                    }.padding(.trailing, 16)
                    
                }.frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                
            }.buttonStyle(.plain)
            
            Rectangle().fill(Color("Grey")).frame(height: 1)
            
            Button(action: {
                selectedMode = .exam
            }){
                
                HStack{
                    
                    VStack(alignment: .leading){
                      
                        Text("Exam Mode")
                            .font(AppFont.semi_bold(16))
                            .padding(.bottom, 10)
                        
                        Text("This timed-mode simulates the actual exam condition. Answers and Explanations will be available after you submit")
                            .font(AppFont.regular(14))
                        
                        
                    }.padding(.vertical, 12)
                        .padding(.horizontal, 16)
                    
                    Spacer()
                    
                    ZStack{
                        if(selectedMode == .exam){
                            Image("set_check")
                        }else{
                            Image("set_uncheck")
                        }
                    }.padding(.trailing, 16)
                    
                }.frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                
            }.buttonStyle(.plain)
            
            Rectangle().fill(Color("Grey")).frame(height: 1)
            
            ZStack{
                if(selectedMode == nil){
                    DisabledButton(buttonText: "Proceed")
                }else{
                    PrimaryButton(buttonText: "Proceed", action: {
                        
                        onModeSelected(selectedMode!)
                        
                    })
                }
            }.frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .padding(.vertical, 30)
            
            
        }.frame(maxWidth: .infinity)
            .background(Color.white)
            .onAppear{
                selectedMode = nil
            }
        
    }
}

#Preview {
    SelectCbtModeView(onModeSelected: {data in })
}
