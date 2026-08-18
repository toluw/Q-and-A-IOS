//
//  NavMenuView.swift
//  Q and A
//
//  Created by GIGL-PC on 29/03/2026.
//

import SwiftUI

struct NavMenuView: View {
    
    
   
    let onMenuSelected: (NavMenu) -> Void
    @ObservedObject var mainScreenViewModel: MainScreenViewModel
    
   
    
    var body: some View {
        VStack(){
           
            Text(mainScreenViewModel.userProfileState.isLoggedIn ? mainScreenViewModel.userProfileState.name : "Not Logged in")
          .font(AppFont.semi_bold(18))
          .foregroundColor(Color.black)
          .padding(.top, 54)
          .padding(.bottom, mainScreenViewModel.userProfileState.isLoggedIn ? 0 : 17)
          
            
        if(mainScreenViewModel.userProfileState.isLoggedIn){
            Text(mainScreenViewModel.userProfileState.email)
            .font(AppFont.regular(14))
            .foregroundColor(Color.black)
            .padding(.top, 4)
            .padding(.bottom, 17)
        }
            
            drawerItem(title: "Community",
                       imageResource:"ic_community",
                       colour: Color("NavDeepBlue")
            ){
                onMenuSelected(.community)
            }
            
          /*  drawerItem(title: "AI Assistant",
                       imageResource:"nav_ai",
                       colour: Color("NavBlue")
            ){
                onMenuSelected(.aiAssistance)
            }
            
            
            drawerItem(title: "Fan Quiz",
                       imageResource:"nav_quiz",
                       colour: Color("NavGold")
            ){
                onMenuSelected(.fanQuiz)
            }
            
           */
           
            if(mainScreenViewModel.userProfileState.isLoggedIn){
                
                drawerItem(title: "CBT History",
                           imageResource:"ic_cbt",
                           colour: Color("NavBlack")
                ){
                    onMenuSelected(.cbtHistory)
                }
                
                drawerItem(title: "Payment History",
                           imageResource:"nav_portal",
                           colour: Color("NavBlue")
                ){
                    onMenuSelected(.paymentHistory)
                }
                
                /*
                
                drawerItem(title: "My Library",
                           imageResource:"nav_library",
                           colour: Color("SecColor")
                ){
                    onMenuSelected(.myLibrary)
                }
               
                
               
                 */
                
                }
            
            
                Divider()
            
            
            HStack{
                Text("More")
                    .font(AppFont.medium(16))
                    .foregroundColor(.gray)
                    .padding(.leading, 20)
                
                Spacer()
            
            }.padding(.top, 30)
                        
              
                    
            /*
            
                drawerItem(title: "Share App",
                       imageResource:"nav_share",
                       colour: Color("NavBlue")
                ){
                    onMenuSelected(.shareApp)
                }
            */
             
            
            if(mainScreenViewModel.userProfileState.isLoggedIn){
               
             /*   drawerItem(title: "My Cart",
                       imageResource:"nav_cart",
                       colour: Color("SecColor")
                ){
                    onMenuSelected(.myCart)
                }
              */
                
                
                drawerItem(title: "Sign Out",
                       imageResource:"nav_signout",
                       colour: Color("NavRed")
                ){
                    onMenuSelected(.signOut)
                }
                
                
            }
            
            
            if(!mainScreenViewModel.userProfileState.isLoggedIn){
                drawerItem(title: "Sign In/Sign Up",
                       imageResource:"nav_sign_in",
                       colour: Color("NavBlack")
                ){
                    onMenuSelected(.signIn)
                }
                
            }
            
            /*
            
            drawerItem(title: "Report Copyright",
                   imageResource:"nav_copyright",
                   colour: Color("NavBlue")
            ){
                onMenuSelected(.reportCopyright)
            }
            
            
            drawerItem(title: "Contact Us",
                   imageResource:"nav_contact_us",
                   colour: Color("NavDeepBlue")
            ){
                onMenuSelected(.contactUs)
            }
            
            
            drawerItem(title: "FAQ",
                   imageResource:"nav_faq",
                   colour: Color("NavGold")
            ){
                onMenuSelected(.faq)
            }
            */
            
            drawerItem(title: "Terms and Conditions",
                   imageResource:"nav_terms",
                   colour: Color("SecColor")
            ){
                onMenuSelected(.privacyPolicy)
            }
            
            drawerItem(title: "Privacy Policy",
                   imageResource:"nav_copyright",
                   colour: Color("NavBlue")
            ){
                onMenuSelected(.privacyPolicy)
            }
            
            drawerItem(title: "About",
                   imageResource:"nav_about",
                   colour: Color("NavBlack")
            ){
                onMenuSelected(.about)
            }
            
            if(mainScreenViewModel.userProfileState.isLoggedIn){
                drawerItem(title: "Deactivate Account",
                       imageResource:"deactivate",
                       colour: Color("NavRed")
                ){
                    onMenuSelected(.deactivateAccount)
                }
            }
            
           
            
            
            Spacer()
            
            
            
            
            
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
            Color.white
            )
            .clipShape(
            .rect(
                topLeadingRadius: 30,
                topTrailingRadius: 30
            )
            )
        
            
            
            
            
           
            
        }
    
    
    private func drawerItem(title: String,
                            imageResource: String,
                            colour: Color,
                            onItemClicked: @escaping () -> Void
                            ) -> some View {
        
        Button(action: onItemClicked){
            HStack {
                
                ZStack{
                  
                 Circle()
                        .fill(colour.opacity(0.2))
                        .frame(width: 40, height: 40)
                  
                    
                    Image(imageResource)
                        .renderingMode(.template)
                        .foregroundColor(colour)
                    
                    
                }.padding(.leading, 20)
                 
                
                
                
                    
                
                
                Text(title).padding(.leading, 12)
                
                Spacer()
                
                Image("select").padding(.trailing, 16)
                
               
            }
            .padding(.top, 8)
            .padding(.bottom, 8)
        }
        .buttonStyle(.plain)
        .frame(width: .infinity)
        
        }

        
    }




#Preview {
    NavMenuView(onMenuSelected: {_ in }, mainScreenViewModel: MainScreenViewModel())
}
