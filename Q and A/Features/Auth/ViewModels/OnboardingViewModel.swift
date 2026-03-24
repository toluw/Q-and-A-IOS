//
//  OnboardingViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 24/03/2026.
//

import Foundation

@MainActor
class OnboardingViewModel: ObservableObject{
    
    
    @Published var onboardingFlow: OnboardingFlow = .intro
    
    
}
