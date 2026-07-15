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
    
    let onCommentClicked: () -> Void
    
    let onLikeClicked: () -> Void
    
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
                    
                    if(post.isEdited){
                        Text("(Edited)")
                            .font(AppFont.medium(12))
                            .foregroundColor(Color("FaintGrey"))
                    }
                    
                    if(!(post.image?.isEmpty ?? true)){
                        FullWidthImageView(url: post.image, placeholderHeight: 64).padding(.top,13)
                    }
                    
                    HStack{
                        
                        Button(action: onCommentClicked){
                            HStack{
                               Image("comment")
                                Text(post.numComment > 1 ? "\(post.numComment) Comments" : "\(post.numComment) Comment")
                                    .foregroundColor(Color("faint"))
                                    .font(AppFont.regular(14))
                            }.contentShape(Rectangle())
                        }.buttonStyle(.plain)
                        
                        
                        
                        Button(action: {
                            
                            onLikeClicked()
                        }){
                            HStack{
                                Image(post.hasLiked ? "active_like" : "in_active_like")
                                
                                Text(String(post.numLikes))
                                    .foregroundColor(Color(post.hasLiked ? "SecColor" : "faint"))
                                    .font(AppFont.regular(14))
                                
                            }.contentShape(Rectangle())
                        }.buttonStyle(.plain)
                            .padding(.leading, 15)
                        
                        
                        Image("eye")
                            .renderingMode(.template)
                            .foregroundStyle(Color("like_blue"))
                            .padding(.leading, 15)
                        
                        Text(String(post.numViews))
                            .foregroundColor(Color("faint"))
                            .font(AppFont.regular(14))
                            
                        
                    }.padding(.top, 12)
                        
                    
                }.padding(.leading, 66)
                 .padding(.trailing, 16)
                
               
                    
                    
                
                
                
                
                
                
            }.frame(maxWidth: .infinity)
                .contentShape(Rectangle())
            
        }.buttonStyle(.plain)
        
      
    }
}

#Preview {
    CbtPostView(post: Post.preview, onClick: {}, onOptionClicked: {}, onCommentClicked: {}, onLikeClicked: {})
}
