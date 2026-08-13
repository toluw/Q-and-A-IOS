//
//  SignUpView.swift
//  Q and A
//
//  Created by GIGL-PC on 13/08/2026.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SignUpView(viewModel: LoginViewModel())
}
