//
//  TableOfContentsView.swift
//  Q and A
//
//  Created by GIGL-PC on 09/07/2026.
//

import SwiftUI
import PDFKit

struct TableOfContentsView: View {

    let items: [PDFOutlineItem]
    let onSelect: (PDFDestination?) -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            List {
                OutlineItemsView(items: items, onSelect: onSelect)
            }
            .listStyle(.plain)
            .navigationTitle("Table of Contents")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

private struct OutlineItemsView: View {

    let items: [PDFOutlineItem]
    let onSelect: (PDFDestination?) -> Void

    var body: some View {
        ForEach(items) { item in
            if item.hasChildren {
                DisclosureGroup(item.label) {
                    OutlineItemsView(items: item.children, onSelect: onSelect)
                }
            } else {
                Button {
                    onSelect(item.destination)
                } label: {
                    Text(item.label)
                        .foregroundColor(.primary)
                }
            }
        }
    }
}
