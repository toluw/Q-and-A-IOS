//
//  PortalBottomSheetView.swift
//  Q and A
//
//  Created by GIGL-PC on 19/10/2026.
//

import SwiftUI

struct PortalBottomSheetView: View {
    
    let title: String
    let items: [PortalItem]
    let onItemClicked: (PortalItem) -> Void
    let onDismissSheet: () -> Void
    
    var body: some View {
        
        
        VStack{
            
            DragIndicator()
            
           
            
            ScrollView(){
                
        
                LazyVStack(spacing: 0){
                    
                    Text(title).font(AppFont.regular(16)).padding(.top, 30)
                     
                     ForEach(items){item in
                         ItemView(item: item.getTitle(), onItemClicked: {
                             onItemClicked(item)
                         }).disabled(!item.isEnabled())
                     }.padding(.top, 20)
                        
                        
                    }
                    
               
                }
            
             
            Spacer()
            
            
        }.background(.white)
        
    }
}

#Preview {
    PortalBottomSheetView(title: "Earnings", items: [PortalItem.earningsAgency(title: "Earnings - Agency", isEnabled: true), PortalItem.earningsCBT(title: "Earnings - CBT", isEnabled: false)], onItemClicked: {dt in}, onDismissSheet: {})
}
