//
//  TabItem.swift
//  Q and A
//
//  Created by GIGL-PC on 17/06/2026.
//

import SwiftUI

struct TabItem: View {
    
    let title: String
    var isSelected: Bool
      let onTap: () -> Void
   
      var body: some View {
          Button(action: onTap) {
              VStack(spacing: 0) {
                  Text(title)
                      .font(isSelected ? AppFont.semi_bold(18) : AppFont.medium(18))
                      .foregroundColor(isSelected ? Color("selected_tab") : Color("deselected_tab"))
                      .padding(.horizontal, 12)
                      .padding(.vertical, 14)
   
                  // Active indicator
                  if(isSelected){
                      
                      Rectangle()
                          .fill(Color("selected_tab"))
                          .frame(height: 3)
                          .clipShape(RoundedRectangle(cornerRadius: 1.5))
                      
                  }
                 
              }
          }
          .buttonStyle(.plain)
      }
    
}

#Preview {
    TabItem(title: "Gift", isSelected: false, onTap: {})
}
