//
//  LoadImageView.swift
//  Q and A
//
//  Created by GIGL-PC on 23/04/2026.
//

import SwiftUI

struct LoadImageView: View {
    
    @Binding var url: String?
    let width: CGFloat
    let height: CGFloat
    let shape = Rectangle()
    
    
    
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
    LoadingImagePreviewWrapper(url: "")
}

struct LoadingImagePreviewWrapper: View{
    
    @State var url: String
    
    init(url: String) {
        self.url = url
    }
   
    var body: some View {
        
     LoadImageView(url: $url, width: 80, height: 80)
        
    }
    
    
}
