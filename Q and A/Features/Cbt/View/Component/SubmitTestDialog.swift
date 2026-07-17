//
//  SubmitTestDialog.swift
//  Q and A
//
//  Created by GIGL-PC on 08/06/2026.
//

import SwiftUI

struct SubmitTestDialog: View {
    
    let onReview: () -> Void
    let onSubmit: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {

                  Text("Are you sure you want to submit\nthis test now?")
                .font(AppFont.regular(15))
                      .multilineTextAlignment(.center)
                      

                  Button(action: onReview) {
                      Text("Review")
                          .font(.title3)
                          .fontWeight(.semibold)
                          .foregroundColor(.white)
                          .frame(maxWidth: .infinity)
                          .frame(height: 60)
                          .background(Color.blue)
                          .cornerRadius(10)
                  }

                  Button(action: onSubmit) {
                      Text("Submit Now")
                          .font(.title3)
                          .fontWeight(.medium)
                          .foregroundColor(.blue)
                          .frame(maxWidth: .infinity)
                          .frame(height: 60)
                          .overlay(
                              RoundedRectangle(cornerRadius: 10)
                                  .stroke(Color.blue, lineWidth: 1.5)
                          )
                  }
              }
              .padding(.horizontal, 32)
              .padding(.vertical, 40)
              .background(Color.white)
              .cornerRadius(24)
              .padding(.horizontal, 24)
    }
}

#Preview {
    SubmitTestDialog(onReview: {}, onSubmit: {})
}
