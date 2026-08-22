//
//  ContactUsScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 22/08/2026.
//

import SwiftUI

struct ContactUsScreen: View {
    
    var links: ContactLinks = .default
    
    var body: some View {
        
                    VStack() {
                        
                        Text("Contact Us")
                            .font(AppFont.semi_bold(18))
                            .padding(.top,16)
                            
                        
                           Spacer()
                           Spacer()
                        Spacer()
                        
                           illustration
                               
                        
                        Spacer()
                    
        
                           descriptionText
                        
                        Spacer()
                        Spacer()
                        Spacer()
        
                           ctaButtons
                        
                        Spacer()
                        Spacer()
        
                        followUsSection
                        
                        Spacer()
                        Spacer()
                        
                       }
                       .padding(.horizontal, 24)
                       
                   
    }
    
    
    private var illustration: some View {
       
         Group {
             if UIImage(named: "contact_us_illustration") != nil {
                 Image("contact_us_illustration")
                     .resizable()
                     .scaledToFit()
             } else {
                 Image(systemName: "headphones.circle.fill")
                     .resizable()
                     .scaledToFit()
                     .foregroundColor(.orange.opacity(0.7))
                     .padding(40)
             }
         }
         .frame(height: 220)
     }
    
    private var descriptionText: some View {
           Text("For Collaborations, Complaints, Enquiries & Advert placement:")
            .font(AppFont.regular(16))
               .frame(maxWidth: .infinity, alignment: .leading)
       }
    
    
    private var ctaButtons: some View {
           VStack(spacing: 20) {
               Button {
                   open(links.whatsApp)
               } label: {
                   HStack(spacing: 10) {
                       Image("whatsapp")
                           
                       Text("Chat on WhatsApp")
                           .font(AppFont.medium(16))
                   }
                   .frame(maxWidth: .infinity)
                   .padding(.vertical, 16)
                   .background(Color.black)
                   .foregroundColor(.white)
                   .cornerRadius(28)
               }
    
               Button {
                   open(links.email)
               } label: {
                   HStack(spacing: 10) {
                       Image("gmail")
                           
                       Text("Send Email")
                           .font(AppFont.medium(16))
                   }
                   .frame(maxWidth: .infinity)
                   .padding(.vertical, 16)
                   .overlay(
                       RoundedRectangle(cornerRadius: 28)
                           .stroke(Color(.systemGray4), lineWidth: 1)
                   )
               }
           }
       }
    
    
    private var followUsSection: some View {
           VStack(spacing: 20) {
               HStack {
                   line
                   Text("Follow us on")
                       .font(AppFont.regular(14))
                   line
               }
    
               HStack(spacing: 28) {
                   socialIcon(systemName: "facebook") {
                       open(links.facebook)
                   }
                   socialIcon(systemName: "x") {
                       open(links.twitter)
                   }
                   socialIcon(systemName: "instagram",) {
                       open(links.instagram)
                   }
                   socialIcon(systemName: "tiktok"){
                       open(links.tiktok)
                   }
               }
           }
       }
    
    
    private var line: some View {
          Rectangle()
              .fill(Color(.systemGray4))
              .frame(height: 1)
      }
    
    private func socialIcon(
        systemName: String,
          action: @escaping () -> Void
      ) -> some View {
          Button(action: action) {
              Image(systemName)
                  
                
          }
      }
    
    private func open(_ url: URL?) {
           guard let url else { return }
           UIApplication.shared.open(url)
       }
}

#Preview {
    ContactUsScreen()
}
