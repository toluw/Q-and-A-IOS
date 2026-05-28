//
//  LoadCircularImageView.swift
//  Q and A
//
//  Created by GIGL-PC on 28/05/2026.
//

import SwiftUI

struct LoadCircularImageView: View {
    let url: String?
    let width: CGFloat
    let height: CGFloat
    let shape = Circle()
    
    
    
    var body: some View {
        
        if(url == nil || url?.isEmpty == true){
            shape
                .fill(Color.gray.opacity(0.3))
              .frame(width: width, height: height)
              
        }else{
            
            
            if let url =   URL(string: url!) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    // Loading state
                                    ProgressView()
                                        .frame(width: width, height: height)
                                        .background(Color.gray.opacity(0.2))
                                        .clipShape(shape)
                                case .success(let image):
                                    // Successfully loaded image
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: width, height: height)
                                        .clipShape(shape)
                                case .failure:
                                    // Failed to load
                                    shape
                                        .fill(Color.gray.opacity(0.3))
                                      .frame(width: width, height: height)
                                @unknown default:
                                    shape
                                        .fill(Color.gray.opacity(0.3))
                                      .frame(width: width, height: height)
                                }
                            }
                        } else {
                            // Null or empty URL string
                            shape
                                .fill(Color.gray.opacity(0.3))
                              .frame(width: width, height: height)
                        }
                
            
        }

        
    }
}

#Preview {
    LoadingCircularImagePreviewWrapper(url: "")
}

struct LoadingCircularImagePreviewWrapper: View{
    
    @State var url: String
    
    init(url: String) {
        self.url = url
    }
   
    var body: some View {
        
     LoadCircularImageView(url: url, width: 80, height: 80)
        
    }
    
    
}
