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
    
    @Published private(set) var activeRoute: MainRoute?
    
    func navigate(route: MainRoute) {
      path.append(route)
        updateActiveRoute()
    }
    
   
    
    func replaceTop(route: MainRoute) {
        guard !path.isEmpty else {
            path.append(route)
            updateActiveRoute()
            return
        }

        path[path.count - 1] = route
        updateActiveRoute()
    }
    
    func pop() {
        _ = path.popLast()
        updateActiveRoute()
    }
    
    func popToRoot() {
        path.removeAll()
        updateActiveRoute()
    }
    
    func pop(n: Int){
        
        guard n > 0, path.count > n - 1 else {
               return
           }
           
       path.removeLast(n)
        updateActiveRoute()
        
    }
    
    private func updateActiveRoute() {
          activeRoute = path.last
      }
}
