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
        
    }
    
   
    
    func replaceTop(route: MainRoute) {
        guard !path.isEmpty else {
            path.append(route)
            
            return
        }

        path[path.count - 1] = route
        
    }
    
    func pop() {
        _ = path.popLast()
        
    }
    
    func popToRoot() {
        path.removeAll()
        
    }
    
    func pop(n: Int){
        
        guard n > 0, path.count > n - 1 else {
               return
           }
           
       path.removeLast(n)
       
        
    }
    
    func updateActiveRoute() {
          activeRoute = path.last
      }
}
