//
//  OptionBottomSheet.swift
//  Q and A
//
//  Created by GIGL-PC on 21/07/2026.
//

import SwiftUI

struct OptionBottomSheet: View {
    
    
    let items: [String]
    let onItemClicked: (String) -> Void
    
    var body: some View {
       
        VStack{
            LazyVStack{
               
                ForEach(items, id: \.self){item in
                    ItemView(item: item, onItemClicked: {
                        onItemClicked(item)
                    })
                }
                
            }.frame(maxWidth: .infinity)
            
           
        }.frame(maxWidth: .infinity)
            .padding(.vertical, 24)
            .background(Color.white)
            .cornerRadius(24)
            .padding(.horizontal, 16)
            
            
        
    }
}

#Preview {
    OptionBottomSheet(items: ["Edit", "Delete"], onItemClicked: {dt in
        
    })
}
