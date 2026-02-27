//
//  IntroStackView.swift
//  Q and A
//
//  Created by GIGL-PC on 29/01/2026.
//

import SwiftUI

struct IntroStackView: View {
    
    @EnvironmentObject var appVM: AppViewModel
    @StateObject  var viewModel = IntroViewModel()
    
    var body: some View {
        Text("Intro")
    }
}

#Preview {
    IntroStackView()
}
