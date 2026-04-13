//
//  MainCbtItemView.swift
//  Q and A
//
//  Created by GIGL-PC on 13/04/2026.
//

import SwiftUI

struct MainCbtItemView: View {
    
    
    let item: BaseCat
    let onClick: () -> Void
    
    var body: some View {
        VStack{
            
            Spacer()
            
            VStack(spacing: 20){
                
                ZStack {
                  Circle()
                    .fill(Color.white)
                    .frame(width: 78, height: 78)
                                
                    Image(item.image)
                }
                
                Text(
                    item.data.item
                ).font(AppFont.medium(18))
                    .foregroundColor(Color("home_grey"))
                
            }
            
            Spacer()
            
            
            
        } .frame(maxWidth: .infinity, minHeight: 180)
            .background(Color(item.background).opacity(0.2))
            .cornerRadius(20)
    }
}

/* #Preview {
 
 let dataModel = DataModel()
 
 MainCbtItemView(
 
 
 
 item: BaseCat(data: dataModel, image: "cat1", background: "col1")
 )
 }
 */
