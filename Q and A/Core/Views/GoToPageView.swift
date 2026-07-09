//
//  GoToPageView.swift
//  Q and A
//
//  Created by GIGL-PC on 09/07/2026.
//

import SwiftUI

struct GoToPageView: View {

    let currentPage: Int
    let pageCount: Int
    let onGo: (Int) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var input: String = ""
    @FocusState private var isFocused: Bool

    private var pageNumber: Int? {
        guard let value = Int(input), value >= 1, value <= pageCount else { return nil }
        return value
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Page number", text: $input)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                } footer: {
                    Text("Enter a page between 1 and \(pageCount).")
                }
            }
            .navigationTitle("Go to Page")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Go") {
                        if let page = pageNumber {
                            onGo(page)
                        }
                    }
                    .disabled(pageNumber == nil)
                }
            }
            .onAppear {
                input = "\(currentPage)"
                isFocused = true
            }
        }
    }
}


#Preview {
    GoToPageView(currentPage: 1, pageCount: 5, onGo: {dt in })
}
