//
//  QuestionBottomSheetView.swift
//  Q and A
//
//  Created by GIGL-PC on 30/04/2026.
//

import SwiftUI

struct QuestionBottomSheetView: View {
    
    let selectQuestion: SelectQuestion
    let onClick: (Int) -> Void
    
    var body: some View {
        
        VStack{
            
          DragIndicator()
            
            ScrollView{
                
                LazyVStack{
                    
                    Text("Number of Questions")
                        .font(AppFont.regular(16))
                        .padding(.top, 24)
                        .padding(.bottom, 24)
                   
                    ForEach(getCbtQuestions(selectQuestion.numQuestion), id: \.self){ data in
                        ItemView(item: String(data), onItemClicked: {
                            
                            onClick(data)
                            
                        })
                    }
                    
                }
              
                   
                
                
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
   
    }
    
    
    func getCbtQuestions(_ numQuestions: Int) -> [Int] {
        var result: [Int] = []

        if numQuestions < 10 {
            for i in 1...(numQuestions) {
                result.append(i)
            }
        } else if numQuestions % 5 == 0 {
            for i in 5...numQuestions {
                if i % 5 == 0 {
                    result.append(i)
                }
            }
        } else {
            let remainder = numQuestions % 5
            let num = numQuestions - remainder

            if num >= 5 {
                for i in 5...num {
                    if i % 5 == 0 {
                        result.append(i)
                    }
                }
            }

            result.append(numQuestions)
        }

        return result.sorted(by: >)
    }
    
}

#Preview {
    
    let selectQuestion = SelectQuestion(position: 0, numQuestion: 50)
    
    QuestionBottomSheetView(selectQuestion: selectQuestion, onClick: {_ in })
}
