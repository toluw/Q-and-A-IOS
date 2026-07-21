//
//  DiscussionNoticeView.swift
//  Q and A
//
//  Created by GIGL-PC on 18/07/2026.
//

import SwiftUI

struct DiscussionNoticeView: View {
    
    let onNoticeClicked: () -> Void
    
    var numNotice: Int
    
    
    
    var body: some View {
        
        Button(){
            onNoticeClicked()
        }label: {
            
            
            Circle()
                .fill(Color("disc").opacity(0.15))
                .frame(width: 36, height: 36)
                .overlay(content: {
                    ZStack(alignment:.bottomTrailing){
                      
                        Image("discussion_message")
                        
                        if(numNotice > 0){
                          
                            Circle()
                                .fill(Color("error_red"))
                                .frame(width: 12, height: 12)
                                .overlay{
                                    Text(String(numNotice))
                                        .font(AppFont.medium(8))
                                        .foregroundColor(.white)
                                }
                                .offset(x: 6, y: -16)
                            
                            
                        }
                        
                        
                            
                    
                    }
                })
            
          
            
            
        }
        
    }
}

#Preview {
    DiscussionNoticeView(onNoticeClicked: {}, numNotice: 2)
}
