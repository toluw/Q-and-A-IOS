//
//  EmptyDiscussionView.swift
//  Q and A
//
//  Created by GIGL-PC on 16/07/2026.
//

import SwiftUI

struct EmptyDiscussionView: View {
    
    
    let startDiscussion: () -> Void
    
    var body: some View {
        
        
        VStack{
            Text("This explanation has not yet been discussed. Please take the lead start the discussion")
                .multilineTextAlignment(.center)
                .font(AppFont.medium(16))
                .foregroundColor(Color("GreyText"))
                .padding(.horizontal, 16)
            
            
            OrangeButton(buttonText: "Start Discussion", action: startDiscussion)
                .padding(.horizontal, 90)
                .padding(.top, 50)
            
            
        }.frame(maxWidth: .infinity)
        
    }
}

#Preview {
    EmptyDiscussionView(startDiscussion: {})
}
