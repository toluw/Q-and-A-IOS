//
//  CommentView.swift
//  Q and A
//
//  Created by GIGL-PC on 03/08/2026.
//

import SwiftUI

struct CommentView: View {
    
    @Binding var comment: Comment
    let onClick: () -> Void
    let onOptionClicked: () -> Void
    let onReplyClicked: () -> Void
    let onLikeClicked: () -> Void
    
    var body: some View {
        Button(action: onClick){
            
            VStack(alignment: .leading){
                
                HStack{
                    
                    if(comment.user.image.isEmpty){
                        AvartarView(name: comment.user.name)
                    }else{
                        LoadCircularImageView(url: comment.user.image, width: 36, height: 36)
                    }
                    
                    Text(comment.user.name)
                        .font(AppFont.semi_bold(14))
                        .padding(.leading, 8)
                    
                    Circle()
                        .frame(width: 3, height: 3)
                        .foregroundColor(Color("GreyText"))
                        .padding(.leading, 6)
                    
                    Text(getTimeDifference(pastTime: comment.createdAt))
                        .foregroundColor(Color("faint"))
                        .font(AppFont.regular(15))
                        .padding(.leading, 6)
                    
                    
                    Spacer()
                    
                    
                    if((UserSettings.email ?? "") == comment.user.email){
                        Button(action: onOptionClicked){
                            
                          Image("horizontal_menu")
                        }.buttonStyle(.plain)
                    }
                    
                    
                }.frame(maxWidth: .infinity)
                  .padding(.top, 17)
                
                VStack(alignment: .leading){
                   
                    ExpandableText(content: comment.content, postLimit: POST_NUM, isLinkify: true)
                    
                    if(comment.isEdited){
                        Text("(Edited)")
                            .font(AppFont.medium(12))
                            .foregroundColor(Color("FaintGrey"))
                    }
                    
                    if(!(comment.image?.isEmpty ?? true)){
                        FullWidthImageView(url: comment.image, placeholderHeight: 64).padding(.top,13)
                    }
                    
                    HStack{
                        
                        Button(action: onReplyClicked){
                            HStack{
                               Image("comment")
                                    .renderingMode(.template)
                                    .foregroundStyle(Color("faint"))
                                Text(comment.numReply > 1 ? "\(comment.numReply) Replies" : "\(comment.numReply) Reply")
                                    .foregroundColor(Color("faint"))
                                    .font(AppFont.regular(14))
                            }.contentShape(Rectangle())
                        }.buttonStyle(.plain)
                        
                        
                        
                        Button(action: {
                            if(comment.hasLiked){
                                comment.numLikes -= 1
                            }else{
                                comment.numLikes += 1
                            }
                            comment.hasLiked = !comment.hasLiked
                            onLikeClicked()
                        }){
                            HStack{
                                Image(comment.hasLiked ? "active_like" : "in_active_like")
                                    .renderingMode(.template)
                                    .foregroundStyle(Color(comment.hasLiked ? "SecColor" : "faint"))
                                
                                Text(String(comment.numLikes))
                                    .foregroundColor(Color(comment.hasLiked ? "SecColor" : "faint"))
                                    .font(AppFont.regular(14))
                                
                            }.contentShape(Rectangle())
                        }.buttonStyle(.plain)
                            .padding(.leading, 15)
                        
                        
                        Image("eye")
                            .renderingMode(.template)
                            .foregroundStyle(Color("faint"))
                            .padding(.leading, 15)
                        
                        Text(String(comment.numViews))
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
    CommentViewPreviewWrapper(comment: Comment.preview)
}

struct CommentViewPreviewWrapper: View{
    
    @State var comment: Comment
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    var body: some View {
        CommentView(comment: $comment, onClick: {}, onOptionClicked: {}, onReplyClicked: {}, onLikeClicked: {})
    }
    
}
