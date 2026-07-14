//
//  CbtPostView.swift
//  Q and A
//
//  Created by GIGL-PC on 14/07/2026.
//

import SwiftUI

struct CbtPostView: View {
    
    let post: Post
    
    let onClick: () -> Void
    
    let onOptionClicked: () -> Void
    
    var body: some View {
        
        Button(action: onClick){
            VStack(alignment: .leading){
              
                HStack{
                    
                    if(post.user.image.isEmpty){
                        AvartarView(name: post.user.name)
                    }else{
                        LoadCircularImageView(url: post.user.image, width: 36, height: 36)
                    }
                    
                    Text(post.user.name)
                        .font(AppFont.semi_bold(14))
                        .padding(.leading, 8)
                    
                    Circle()
                        .frame(width: 3, height: 3)
                        .foregroundColor(Color("GreyText"))
                        .padding(.leading, 8)
                    
                    Text(getTimeDifference(pastTime: post.createdAt))
                        .foregroundColor(Color("faint"))
                        .font(AppFont.regular(15))
                        .padding(.leading, 8)
                    
                    
                    Spacer()
                    
                    
                    if((UserSettings.email ?? "") == post.user.email){
                        Button(action: onOptionClicked){
                            
                          Image("horizontal_menu")
                        }.buttonStyle(.plain)
                    }
                    
                    
                    
                    
                    
                    
                    
                }.frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    .padding(.top, 17)
                
                
                VStack(alignment: .leading){
                   
                    ExpandableText(content: post.content, postLimit: POST_NUM)
                        
                    
                }.padding(.leading, 66)
                 .padding(.trailing, 16)
                
               
                    
                    
                
                
                
                
                
                
            }.frame(maxWidth: .infinity)
                .contentShape(Rectangle())
            
        }.buttonStyle(.plain)
        
      
    }
}

#Preview {
    CbtPostView(post: Post.preview, onClick: {}, onOptionClicked: {})
}
