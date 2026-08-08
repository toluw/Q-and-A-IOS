//
//  ReplyView.swift
//  Q and A
//
//  Created by GIGL-PC on 08/08/2026.
//

import SwiftUI

struct ReplyView: View {
    
    @Binding var reply: Reply
    let onOptionClicked: () -> Void
    let onReplyClicked: () -> Void
    let onLikeClicked: () -> Void
    
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack{
                
                if(reply.user.image.isEmpty){
                    AvartarView(name: reply.user.name)
                }else{
                    LoadCircularImageView(url: reply.user.image, width: 36, height: 36)
                }
                
                Text(reply.user.name)
                    .font(AppFont.semi_bold(14))
                    .padding(.leading, 8)
                
                Circle()
                    .frame(width: 3, height: 3)
                    .foregroundColor(Color("GreyText"))
                    .padding(.leading, 6)
                
                Text(getTimeDifference(pastTime: reply.createdAt))
                    .foregroundColor(Color("faint"))
                    .font(AppFont.regular(15))
                    .padding(.leading, 6)
                
                
                Spacer()
                
                
                if((UserSettings.email ?? "") == reply.user.email){
                    Button(action: onOptionClicked){
                        
                      Image("horizontal_menu")
                    }.buttonStyle(.plain)
                }
                
                
            }.frame(maxWidth: .infinity)
              .padding(.top, 14)
            
            if let quote = reply.quote{
                
                Button(action: {
                    reply.truncateText = !reply.truncateText
                }){
                   
                    ZStack{
                        
                        Text(
                            "\(quote.name): \(quote.content)"
                        ).foregroundColor(Color("text_grey"))
                            .font(AppFont.regular(12))
                            .lineLimit(reply.truncateText ? 3 : nil)
                            .truncationMode(.tail)
                            .padding(10)
                        
                         
                        
                    }.frame(width: .infinity)
                        .background(Color("FaintGrey").opacity(0.15))
                        .cornerRadius(8)
                        .padding(.leading, 50)
                        .padding(.trailing, 16)
                        .contentShape(Rectangle())
                        .padding(.bottom, 5)
                    
                }.buttonStyle(.plain)
                
             
                
            }
            
            VStack(alignment: .leading){
                
                Text(LinkifiedText.attributedString(text: reply.content)).font(AppFont.regular(14))
               
            
                
                if(reply.isEdited){
                    Text("(Edited)")
                        .font(AppFont.medium(12))
                        .foregroundColor(Color("FaintGrey"))
                }
                
                if(!(reply.image?.isEmpty ?? true)){
                    FullWidthImageView(url: reply.image, placeholderHeight: 64).padding(.top,13)
                }
                
                HStack{
                    
                    Button(action: onReplyClicked){
                        HStack{
                           Image("reply")
                            
                            Text("Reply")
                                .foregroundColor(Color("faint"))
                                .font(AppFont.regular(14))
                                
                        }.contentShape(Rectangle())
                    }.buttonStyle(.plain)
                    
                    
                    
                    Button(action: {
                        if(reply.hasLiked){
                            reply.numLikes -= 1
                        }else{
                            reply.numLikes += 1
                        }
                        reply.hasLiked = !reply.hasLiked
                        onLikeClicked()
                    }){
                        HStack{
                            Image(reply.hasLiked ? "active_like" : "in_active_like")
                                .renderingMode(.template)
                                .foregroundStyle(Color(reply.hasLiked ? "SecColor" : "faint"))
                            
                            Text(String(reply.numLikes))
                                .foregroundColor(Color(reply.hasLiked ? "SecColor" : "faint"))
                                .font(AppFont.regular(14))
                            
                        }.contentShape(Rectangle())
                    }.buttonStyle(.plain)
                        .padding(.leading, 15)
                    
                    
                    Image("eye")
                        .renderingMode(.template)
                        .foregroundStyle(Color("faint"))
                        .padding(.leading, 15)
                    
                    Text(String(reply.numViews))
                        .foregroundColor(Color("faint"))
                        .font(AppFont.regular(14))
                        
                    
                }.padding(.top, 12)
                
              
                    
                
            }.padding(.leading, 50)
             .padding(.trailing, 16)
            
            Divider()
                .padding(.top, 12)
            
            
        }.frame(maxWidth: .infinity)
    }
}

#Preview {
    ReplyViewPreviewWrapper(reply: Reply.preview)
}

struct ReplyViewPreviewWrapper: View {
    
    @State var reply: Reply
    
    init(reply: Reply) {
        self.reply = reply
    }
    
    var body: some View {
        ReplyView(reply: $reply, onOptionClicked: {}, onReplyClicked: {}, onLikeClicked: {})
    }
}
