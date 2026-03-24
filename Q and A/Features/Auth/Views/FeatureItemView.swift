//
//  FeatureItemView.swift
//  Q and A
//
//  Created by GIGL-PC on 24/03/2026.
//

import SwiftUI

struct FeatureItemView: View {
    
    let feature: RoleFeature
    
    var body: some View {
        HStack(alignment: .center, spacing: 18) {
                 
                 Image(systemName: feature.icon)
                     .frame(width: 45, height: 45)
                     .background(Color.gray.opacity(0.1))
                     .clipShape(RoundedRectangle(cornerRadius: 10))
                 
                 VStack(alignment: .leading, spacing: 4) {
                     Text(feature.title)
                         .font(AppFont.medium(16))
                         .foregroundColor(.black)
                     
                     Text(feature.description)
                         .font(AppFont.regular(13))
                         .foregroundColor(.black)
                 }
             }
    }
}

#Preview {
    FeatureItemView(feature: RoleFeature(
        icon: "resource",
        title: "Resources",
        description: "Get access to millions of Educational and Career resources in text, audio & video formats."
    ))
}
