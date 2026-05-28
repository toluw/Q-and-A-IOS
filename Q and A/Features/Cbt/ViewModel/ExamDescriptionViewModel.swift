//
//  ExamDescriptionViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 27/05/2026.
//

import Foundation

@MainActor
class ExamDescriptionViewModel: ObservableObject{
    
    
    @Published var selectedColor: String = "cb0"
    
    let colourList: [String] = ["cb0", "cb1", "cb2", "cb3"]
    
    
    func pickColor() {
            selectedColor = colourList.randomElement() ?? "cb0"
        }
   
    
    
}

