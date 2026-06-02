//
//  FullWidthImageView.swift
//  Q and A
//
//  Created by GIGL-PC on 02/06/2026.
//

import SwiftUI

struct FullWidthImageView: View {
    let url: String?
       let placeholderHeight: CGFloat

       var body: some View {

           if let urlString = url,
              !urlString.isEmpty,
              let imageUrl = URL(string: urlString) {

               AsyncImage(url: imageUrl) { phase in

                   switch phase {

                   case .empty:
                       Rectangle()
                           .fill(Color.gray.opacity(0.3))
                           .frame(maxWidth: .infinity)
                           .frame(height: placeholderHeight)

                   case .success(let image):
                       image
                           .resizable()
                           .aspectRatio(contentMode: .fit)
                           .frame(maxWidth: .infinity)

                   case .failure:
                       Rectangle()
                           .fill(Color.gray.opacity(0.3))
                           .frame(maxWidth: .infinity)
                           .frame(height: placeholderHeight)

                   @unknown default:
                       Rectangle()
                           .fill(Color.gray.opacity(0.3))
                           .frame(maxWidth: .infinity)
                           .frame(height: placeholderHeight)
                   }
               }

           } else {

               Rectangle()
                   .fill(Color.gray.opacity(0.3))
                   .frame(maxWidth: .infinity)
                   .frame(height: placeholderHeight)
           }
       }
}

#Preview {
    FullWidthImageView(url: nil, placeholderHeight: 50)
}
