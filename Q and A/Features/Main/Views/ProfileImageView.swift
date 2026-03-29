//
//  ProfileImageView.swift
//  Q and A
//
//  Created by GIGL-PC on 29/03/2026.
//

import SwiftUI

struct ProfileImageView: View {
    
    var profileImageURLString: String = UserSettings.profileImage ?? ""
    
    var body: some View {
        
        if let url = URL(string: profileImageURLString), !profileImageURLString.isEmpty {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                // Loading state
                                ProgressView()
                                    .frame(width: 80, height: 80)
                                    .background(Color.gray.opacity(0.2))
                                    .clipShape(Circle())
                            case .success(let image):
                                // Successfully loaded image
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                            case .failure:
                                // Failed to load
                                placeholderImage
                            @unknown default:
                                placeholderImage
                            }
                        }
                    } else {
                        // Null or empty URL string
                        placeholderImage
                    }
            
        
        
    }
    
    
    @ViewBuilder
    private var placeholderImage: some View {
            Image("default_profile")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .background(Color.white)
                .clipShape(Circle())
        }
}

#Preview {
    ProfileImageView()
}
