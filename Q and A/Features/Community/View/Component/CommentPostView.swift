//
//  CommentPostView.swift
//  Q and A
//
//  Created by GIGL-PC on 03/08/2026.
//

import SwiftUI

struct CommentPostView: View {
    
    @Binding var post: Post
    let onLikeClicked: () -> Void
    
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack{
                
                if(post.user.image.isEmpty){
                    AvartarView(name: post.user.name, width: 40, height: 40)
                }else{
                    LoadCircularImageView(url: post.user.image, width: 40, height: 40)
                }
                
                Text(post.user.name)
                    .font(AppFont.semi_bold(16))
                    .padding(.leading, 8)
                
                Circle()
                    .frame(width: 3, height: 3)
                    .foregroundColor(Color("GreyText"))
                    .padding(.leading, 6)
                
                Text(getTimeDifference(pastTime: post.createdAt))
                    .foregroundColor(Color("faint"))
                    .font(AppFont.regular(16))
                    .padding(.leading, 6)
                
                
                Spacer()
                
                
                
                
                
                
                
                
                
            }.frame(maxWidth: .infinity)
              .padding(.top, 17)
            
            
            Spacer().frame(height: 7)
            
            if(!post.title.isEmpty){
                
                HStack{
                    Text(post.title)
                        .font(AppFont.semi_bold(16))
                    
                    Spacer()
                    
                }.padding(.bottom,1)
                
                
                    
                
            }
            
            Text(LinkifiedText.attributedString(text: post.content))
                .font(AppFont.regular(16))
            
            
            if(!(post.image?.isEmpty ?? true)){
                FullWidthImageView(url: post.image, placeholderHeight: 64).padding(.top,13)
            }
            
            
            if(!post.link.isEmpty){
                
                PrimaryButton(buttonText: "Apply Now", action: {
                    openLink(link: post.link)
                }).padding(.top, 24)
                
            }
            
            
            HStack{
                
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
                
                
                HStack{
                   Image("comment")
                    Text(String(post.numComment))
                        .foregroundColor(Color("faint"))
                        .font(AppFont.regular(14))
                }.padding(.leading, 15)
                
                Image("eye")
                    .renderingMode(.template)
                    .foregroundStyle(Color("like_blue"))
                    .padding(.leading, 15)
                
                Text(String(post.numViews))
                    .foregroundColor(Color("faint"))
                    .font(AppFont.regular(14))
                
                
                Spacer()
                
            }.padding(.top,15)
            
            
          
        
            
        }.frame(maxWidth: .infinity)
        
    }
    
    
    private func openLink(link: String){
        guard let url = link.normalizedURL() else { return }
        openURL(url)
    }
}

#Preview {
    CommentPostPreviewWrapper(post: Post.preview)
}


struct CommentPostPreviewWrapper: View{
    
    @State var post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    var body: some View{
        CommentPostView(post: $post, onLikeClicked: {})
    }
}
