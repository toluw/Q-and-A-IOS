//
//  NavDrawer.swift
//  Q and A
//
//  Created by GIGL-PC on 27/03/2026.
//

import SwiftUI

struct NavDrawer: View {
    
    var onClose: () -> Void
    
    let isLoggedIn = UserSettings.isLoggedIn
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            
            ZStack(alignment: .top){
                
               
                VStack(spacing: 0){
                    
                
                    // Top "Edit Profile" Button
                    
                    if(isLoggedIn){
                        HStack {
                            Spacer()
                            Button(action: {
                              editProfile()
                            }) {
                            Text("Edit Profile")
                                .foregroundColor(Color("SecColor"))
                                .font(AppFont.regular(14))
                                .padding(.trailing, 24)
                                .padding(.top, 32)
                                }
                            }
                        
                    }else{
                        HStack {
                            Spacer()
                            Button(action: {
                              signIn()
                            }) {
                            Text("Sign In")
                                .foregroundColor(Color("SecColor"))
                                .font(AppFont.regular(14))
                                .padding(.trailing, 24)
                                .padding(.top, 32)
                                }
                            }
                    }
                    
                    
                    ZStack(alignment: .top){
                        
                        NavMenuView()
                            .padding(.top, 75)
                        
                        ZStack(alignment: .bottomTrailing){
                            //Dynamic Image Loading
                            ProfileImageView()
                            
                            // Orange Edit Badge
                            if(isLoggedIn){
                                Circle()
                                    .fill(Color.orange)
                                    .frame(width: 26, height: 26)
                                    .overlay(
                                      Image("edit-2")
                                          .font(.system(size: 14, weight: .bold))
                                          .foregroundColor(.white)
                                    )
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                    .offset(x: 5, y: -54)
                            }
                            
                            
                        }.padding(.top, 35)
                            .onTapGesture {
                               editProfile()
                            }
                        
                        
                    }.frame(width: .infinity)
                    
                   
                   
                        
                        
                        
                    
                }
                
            }
          .background(Color("NavHeaderBg")).ignoresSafeArea()
            
        }
        
       
        
    }
    
    private func editProfile(){
        
    }
    
    private func signIn(){
    
    }
    
    private func drawerItem(title: String, imageResource: String, colour: Color) -> some View {
          HStack {
              Circle()
                  .fill(colour.opacity(0.2))
                  .frame(width: 40, height: 40)
              
              Text(title)
              
              Spacer()
              
              Image(imageResource)
                  .foregroundColor(colour)
          }
      }
}

#Preview {
    NavDrawer(){}
}
