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
    @State private var showGoToPage = false

    var body: some View {
        PDFKitView(viewModel: viewModel)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !viewModel.outlineItems.isEmpty {
                        Button {
                            showTOC = true
                        } label: {
                            Image(systemName: "list.bullet")
                        }
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                if viewModel.pageCount > 0 {
                    Button {
                        showGoToPage = true
                    } label: {
                        Text("Page \(viewModel.currentPage) of \(viewModel.pageCount)")
                            .font(.footnote)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(.thinMaterial, in: Capsule())
                    }
                    .padding(.bottom, 8)
                }
            }
            .sheet(isPresented: $showTOC) {
                TableOfContentsView(items: viewModel.outlineItems) { destination in
                    showTOC = false
                    viewModel.navigate(to: destination)
                }
            }
            .sheet(isPresented: $showGoToPage) {
                GoToPageView(
                    currentPage: viewModel.currentPage,
                    pageCount: viewModel.pageCount
                ) { page in
                    showGoToPage = false
                    viewModel.goToPage(page)
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
