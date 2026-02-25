//
//  AppFont.swift
//  Q and A
//
//  Created by GIGL-PC on 08/02/2026.
//

import Foundation
import SwiftUI

struct AppFont {
    static func regular(_ size: CGFloat) -> Font {
        .custom("Gilroy-Regular", size: size)
    }
    
    static func thin(_ size: CGFloat) -> Font {
        .custom("Gilroy-Thin", size: size)
    }
    
    static func light(_ size: CGFloat) -> Font {
        .custom("Gilroy-Light", size: size)
    }
    
    static func medium(_ size: CGFloat) -> Font {
        .custom("Gilroy-Medium", size: size)
    }
    
    static func semi_bold(_ size: CGFloat) -> Font {
        .custom("Gilroy-SemiBold", size: size)
    }
    
    static func bold(_ size: CGFloat) -> Font {
        .custom("Gilroy-Bold", size: size)
    }
}
