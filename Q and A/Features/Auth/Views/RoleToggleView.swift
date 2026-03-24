//
//  RoleToggleView.swift
//  Q and A
//
//  Created by GIGL-PC on 23/03/2026.
//

import SwiftUI

struct RoleToggleView: View {
    
    @Binding var selectedRole: UserRole
    
    var body: some View {
        HStack(spacing: 0) {
                   
                   toggleButton(title: "Access material", role: .buyer)
                   toggleButton(title: "Become a seller", role: .seller)
               }
               .background(Color.gray.opacity(0.2))
               .clipShape(Capsule())
    }
    
    private func toggleButton(title: String, role: UserRole) -> some View {
         Button {
             selectedRole = role
         } label: {
             Text(title)
                 .font(AppFont.medium(18))
                 .foregroundColor(selectedRole == role ? .white : .gray)
                 .frame(maxWidth: .infinity)
                 .padding(.vertical, 10)
                 .background(
                     selectedRole == role ? Color("SecColor") : Color.clear
                 )
         }
     }
}

#Preview {
    RoleTogglePreviewWrapper()
}


struct RoleTogglePreviewWrapper: View {
    
    @State private var selectedRole: UserRole = .buyer
    
    var body: some View {
        RoleToggleView(selectedRole: $selectedRole)
    }
}
