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
    
    func navigateAndPop(route: MainRoute, pop: Int){
        path.append(route)
        
        if(pop == 0){
            return
        }
        
        for i in 1...pop {
            
            let index = path.count - 1 - i
            
            if(index < 0){
                return
            }
            
            if(path.indices.contains(index)){
                path.remove(at: index)
            }
            
        }
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
}
