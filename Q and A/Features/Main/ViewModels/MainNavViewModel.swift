//
//  MainNavViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 26/03/2026.
//

import Foundation

@MainActor
class MainNavViewModel: ObservableObject {
    
    @Published var path: [MainRoute] = []
    
    func navigate(route: MainRoute) {
      path.append(route)
    }
    
    func pop() {
        _ = path.popLast()
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
