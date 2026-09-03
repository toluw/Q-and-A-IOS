//
//  DragIndicator.swift
//  Q and A
//
//  Created by GIGL-PC on 03/09/2026.
//

import SwiftUI

struct DragIndicator: View {
    
    var body: some View {
        Capsule()
            .fill(Color.gray.opacity(0.4))
            .frame(width: 36, height: 5)
            .padding(.top, 8)
    }
}

#Preview {
    DragIndicator()
}
