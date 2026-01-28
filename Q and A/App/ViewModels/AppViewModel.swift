//
//  AppViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 28/01/2026.
//

import Foundation

@MainActor
class AppViewModel: ObservableObject{
    
    @Published var appFlow: AppFlow = .splash
    
}
