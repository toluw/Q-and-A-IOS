//
//  ContentSegment.swift
//  Q and A
//
//  Created by GIGL-PC on 24/06/2026.
//

import Foundation

enum ContentSegment: Identifiable {
    case text(String)
    case math(String)

    var id: UUID {
        UUID()
    }
}
