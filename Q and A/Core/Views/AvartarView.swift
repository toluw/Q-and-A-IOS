//
//  AvartarView.swift
//  Q and A
//
//  Created by GIGL-PC on 14/07/2026.
//

import SwiftUI

struct AvartarView: View {
    
    let name: String
    
    private var initial: String {
           name
               .trimmingCharacters(in: .whitespacesAndNewlines)
               .first?
               .uppercased() ?? "?"
    }
    
    var body: some View {
        Circle()
              .fill(getAvarterColor(name: name))
              .frame(width: 36, height: 36)
              .overlay(
                      Text(initial)
                        .font(AppFont.semi_bold(18))
                        .foregroundColor(.white)
                  )
    }
}

#Preview {
    AvartarView(name: "Toluwase Oke")
}
