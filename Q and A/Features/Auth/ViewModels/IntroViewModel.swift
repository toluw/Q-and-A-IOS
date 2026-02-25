//
//  IntroViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 25/02/2026.
//

import Foundation


@MainActor
final class IntroViewModel: ObservableObject{
    

    @Published var currentIndex: Int = 0
    
    let pages: [IntroPage] = [
            IntroPage(
                imageName: "intro1",
                title: "intro1_title",
                subtitle: "intro1_description."
            ),
            IntroPage(
                imageName: "intro2",
                title: "intro2_title",
                subtitle: "intro2_description."
            ),
            IntroPage(
                imageName: "intro3",
                title: "intro3_title",
                subtitle: "intro3_description"
            )
        ]
    
    var isLastPage: Bool {
           currentIndex == pages.count - 1
       }
    
    func next() {
            if !isLastPage {
                currentIndex += 1
            }
        }
        
        func previous() {
            if currentIndex > 0 {
                currentIndex -= 1
            }
        }
}
