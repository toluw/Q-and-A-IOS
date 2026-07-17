//
//  CbtPostView.swift
//  Q and A
//
//  Created by GIGL-PC on 14/07/2026.
//

import SwiftUI

struct CbtPostView: View {
    
    @Binding var post: Post
    
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
                        .padding(.leading, 6)
                    
                    Text(getTimeDifference(pastTime: post.createdAt))
                        .foregroundColor(Color("faint"))
                        .font(AppFont.regular(15))
                        .padding(.leading, 6)
                    
                    
                    Spacer()
                    
                    
                    if((UserSettings.email ?? "") == post.user.email){
                        Button(action: onOptionClicked){
                            
                          Image("horizontal_menu")
                        }.buttonStyle(.plain)
                    }
                    
                    
                    
                    
                    
                    
                    
                }.frame(maxWidth: .infinity)
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
                            if(post.hasLiked){
                                post.numLikes -= 1
                            }else{
                                post.numLikes += 1
                            }
                            post.hasLiked = !post.hasLiked
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
                        
                    
                }.padding(.leading, 50)
                 .padding(.trailing, 16)
                
               
                    
                    
                
                
                
                
                
                
            }.frame(maxWidth: .infinity)
                .contentShape(Rectangle())
            
        }.buttonStyle(.plain)
        
      
    }
}

#Preview {
    CbtPostPreviewWrapper(post: Post.preview)
}

struct CbtPostPreviewWrapper: View{
    
    @State var post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    var body: some View{
        CbtPostView(post: $post, onClick: {}, onOptionClicked: {}, onCommentClicked: {}, onLikeClicked: {})
    }
}
