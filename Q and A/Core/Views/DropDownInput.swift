//
//  DropDownInput.swift
//  Q and A
//
//  Created by GIGL-PC on 24/04/2026.
//

import SwiftUI

struct DropDownInput: View {
    
    @Binding var text: String
    let hint: String
    let onItemClicked: () -> Void
    
    
    var body: some View {
        Button {
        } label: {
            HStack {
                Text(text.isEmpty ?  hint : text)
                    .foregroundColor(text.isEmpty ? .gray : .primary)
                    .font(AppFont.regular(16))
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .foregroundColor(.blue)
            }
            .padding()
            .frame(height: 47)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5))
            )
        }
                   
               }
    }


#Preview {
    DropDownInputPreviewWrapper()
}


struct DropDownInputPreviewWrapper: View {
    
    @State var text: String = "Cubbes"
    
    
    var body: some View {
        DropDownInput(
            text: $text, hint: "Select", onItemClicked: {}
        )
    }
    
    
}
