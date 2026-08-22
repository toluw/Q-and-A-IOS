//
//  AboutScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 22/08/2026.
//

import SwiftUI

struct AboutScreen: View {
    
    private var appVersion: String {
            Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        }

    
    var body: some View {
        VStack{
            
            HStack{
                
                Spacer()
                
                HStack{
                    
                    Image("qanda")
                    VStack(alignment: .leading){
                        
                        Text("Q and A").font(AppFont.semi_bold(18))
                        Text("Version: \(appVersion)").font(AppFont.regular(14))
                        
                        
                    }.padding(.leading,4)
                    
                   
                    
                }.padding(.top,24)
                
                Spacer()
                Spacer()
                
            }
            
            
            
            
            Text(aboutApp)
                .font(AppFont.regular(16))
                .padding(.top,16)
                .padding(.horizontal,16)
            
            
            HStack{
                
                Text("Copyright (C) 2026 Techpedia Integrated Services ltd")
                    .font(AppFont.medium(16))
                
               Spacer()
            }.padding(.top,16)
             .padding(.horizontal,16)
            
            
                
        }
        
        Spacer()
        
        
    }
}

#Preview {
    AboutScreen()
}
