//
//  PdfReaderScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 09/07/2026.
//

import SwiftUI

struct PdfReaderScreen: View {
    
    let fileUrl: URL
    @StateObject private var viewModel = PDFViewModel()
    @State private var showTOC = false
    
    var body: some View {
           PDFKitView(viewModel: viewModel)
               .navigationBarTitleDisplayMode(.inline)
               .toolbar {
                   if !viewModel.outlineItems.isEmpty {
                       ToolbarItem(placement: .navigationBarTrailing) {
                           Button {
                               showTOC = true
                           } label: {
                               Image(systemName: "list.bullet")
                           }
                       }
                   }
               }
               .sheet(isPresented: $showTOC) {
                   TableOfContentsView(items: viewModel.outlineItems) { destination in
                       showTOC = false
                       viewModel.navigate(to: destination)
                   }
               }
               .onAppear {
                   viewModel.load(url: fileUrl)
               }
       }
}

/*
 #Preview {
 PdfReaderScreen(
 
 )
 }
 */
