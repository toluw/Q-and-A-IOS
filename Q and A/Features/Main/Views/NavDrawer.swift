//
//  NavDrawer.swift
//  Q and A
//
//  Created by GIGL-PC on 27/03/2026.
//

import SwiftUI

struct NavDrawer: View {
    
    let onMenuSelected: (NavMenu) -> Void
    
    
    @ObservedObject var mainScreenViewModel: MainScreenViewModel
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            
            ZStack(alignment: .top){
                
               
                VStack(spacing: 0){
                    
                
                    // Top "Edit Profile" Button
                    
                    if(mainScreenViewModel.userProfileState.isLoggedIn){
                     /*   HStack {
                            Spacer()
                            Button(action: {
                                onMenuSelected(.editProfile)
                            }) {
                            Text("Edit Profile")
                                .foregroundColor(Color("SecColor"))
                                .font(AppFont.regular(14))
                                .padding(.trailing, 24)
                                .padding(.top, 32)
                                }
                            }
                      */
                        
                    }else{
                        HStack {
                            Spacer()
                            Button(action: {
                                onMenuSelected(.signIn)
                            }) {
                            Text("Sign In")
                                .foregroundColor(Color("SecColor"))
                                .font(AppFont.medium(16))
                                .padding(.trailing, 24)
                                .padding(.top, 32)
                                }
                            }
                    }
                    
                    
                    ZStack(alignment: .top){
                        
                        NavMenuView(onMenuSelected: onMenuSelected, mainScreenViewModel: mainScreenViewModel)
                            .padding(.top, 75)
                            
                        
                        ZStack(alignment: .bottomTrailing){
                            //Dynamic Image Loading
                            ProfileImageView(mainScreenViewModel: mainScreenViewModel)
                            
                            // Orange Edit Badge
                            if(mainScreenViewModel.userProfileState.isLoggedIn){
                                
                                /*
                                
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
                                 
                                 */
                            }
                            
                            
                        }.padding(.top, 35)
                            .onTapGesture {
                                onMenuSelected(.editProfile)
                            }
                        
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                   
                   
                        
                        
                        
                    
                }
                
            }
          .background(Color("NavHeaderBg")).ignoresSafeArea()
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        
       
        
    }
    
   
    
   
}

#Preview {
    NavDrawer(onMenuSelected: {_ in }, mainScreenViewModel: MainScreenViewModel())
}
