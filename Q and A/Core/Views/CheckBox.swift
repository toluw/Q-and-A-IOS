//
//  CheckBox.swift
//  Q and A
//
//  Created by GIGL-PC on 24/04/2026.
//

import SwiftUI

struct CheckBox: View {
   
    @Binding var isChecked: Bool
        var title: String

        var body: some View {
            Button(action: {
                isChecked.toggle()
            }) {
                HStack {
                    Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                        .foregroundColor(isChecked ? Color("SecColor") : .gray)

                    Text(title)
                        .font(AppFont.regular(14))
                        .foregroundColor(.primary)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
    
}

#Preview {
    CheckBoxPreviewWrapper()
}

struct CheckBoxPreviewWrapper: View{
    
    @State var isChecked: Bool = true
   
    var body: some View {
        CheckBox(isChecked: $isChecked, title: "Approved")
    }
    
}
