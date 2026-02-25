//
//  IntroPage.swift
//  Q and A
//
//  Created by GIGL-PC on 24/02/2026.
//

import Foundation

struct IntroPage: Identifiable {
    let id = UUID()
    let imageName: String
    let title: LocalizedStringResource
    let subtitle: LocalizedStringResource
}
