//
//  ReplyCommentView.swift
//  Q and A
//
//  Created by GIGL-PC on 08/08/2026.
//

import SwiftUI

struct ReplyCommentView: View {
    
    @Binding var comment: Comment
    let onLikeClicked: () -> Void
    
    @Environment(\.openURL) private var openURL

    
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack{
                
                if(comment.user.image.isEmpty){
                    AvartarView(name: comment.user.name, width: 40, height: 40)
                }else{
                    LoadCircularImageView(url: comment.user.image, width: 40, height: 40)
                }
                
                Text(comment.user.name)
                    .font(AppFont.semi_bold(16))
                    .padding(.leading, 8)
                
                Circle()
                    .frame(width: 3, height: 3)
                    .foregroundColor(Color("GreyText"))
                    .padding(.leading, 6)
                
                Text(getTimeDifference(pastTime: comment.createdAt))
                    .foregroundColor(Color("faint"))
                    .font(AppFont.regular(16))
                    .padding(.leading, 6)
                
                
                Spacer()
                
                
                
                
                
                
                
                
                
            }.frame(maxWidth: .infinity)
              .padding(.top, 17)
            
            
            Spacer().frame(height: 7)
            
           
            
            Text(LinkifiedText.attributedString(text: comment.content))
                .font(AppFont.regular(16))
            
            
            if(!(comment.image?.isEmpty ?? true)){
                FullWidthImageView(url: comment.image, placeholderHeight: 64).padding(.top,13)
            }
            
            
            
            
            HStack{
                
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
                        
                        Text(String(comment.numLikes))
                            .foregroundColor(Color(comment.hasLiked ? "SecColor" : "faint"))
                            .font(AppFont.regular(14))
                        
                    }.contentShape(Rectangle())
                }.buttonStyle(.plain)
                
                
                HStack{
                   Image("comment")
                    Text(String(comment.numReply))
                        .foregroundColor(Color("faint"))
                        .font(AppFont.regular(14))
                }.padding(.leading, 15)
                
                Image("eye")
                    .renderingMode(.template)
                    .foregroundStyle(Color("like_blue"))
                    .padding(.leading, 15)
                
                Text(String(comment.numViews))
                    .foregroundColor(Color("faint"))
                    .font(AppFont.regular(14))
                
                
                Spacer()
                
            }.padding(.top,15)
            
            
          
        
            
        }.frame(maxWidth: .infinity)
        
    }
}

#Preview {
    ReplyCommentPreviewWrapper(comment: Comment.preview)
}


struct ReplyCommentPreviewWrapper: View {
    
    @State var comment: Comment
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    
    var body: some View {
        ReplyCommentView(comment: $comment, onLikeClicked:{})
    }
    
}
