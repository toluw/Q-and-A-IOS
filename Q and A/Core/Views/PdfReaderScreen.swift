//
//  PdfReaderScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 09/07/2026.
//

import SwiftUI

struct PdfReaderScreen: View {
    
    let fileUrl: URL
    
    var body: some View {
        
        PDFKitView(fileURL: fileUrl)
        
    }
}

/*
 #Preview {
 PdfReaderScreen(
 
 )
 }
 */
