//
//  BundleBottomSheetView.swift
//  Q and A
//
//  Created by GIGL-PC on 16/10/2026.
//

import SwiftUI

struct BundleBottomSheetView: View {
    let offer: Offer
    let bundleId: String?

    @StateObject var viewModel: BundleViewModel = .init()
    var onContinue: ([UserBundle]) -> Void
    let onDismis: () -> Void

   

    private let accent = Color(hex: "#FF4149")
    private let ink = Color(hex: "#101D3C")
    private let muted = Color(hex: "#929BA8")

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                Capsule()
                    .fill(Color(hex: "#B8BFCA"))
                    .frame(width: 42, height: 6)
                    .accessibilityHidden(true)
                HStack {
                    Spacer()
                    Button { onDismis() } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 19, weight: .regular))
                            .foregroundStyle(Color.gray)
                            .frame(width: 44, height: 44)
                    }
                    .accessibilityLabel("Close bundles")
                }
            }
            .frame(height: 44)
            .padding(.horizontal, 12)

            VStack(alignment: .leading, spacing: 6) {
                Text(viewModel.state.title.isEmpty ? offer.title : viewModel.state.title)
                    .font(AppFont.semi_bold(18))
                    .foregroundStyle(ink)
                if !viewModel.state.description.isEmpty {
                    Text(viewModel.state.description)
                        .font(AppFont.regular(14))
                        .foregroundStyle(Color(hex: "#5B6576"))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 8)
            .padding(.bottom, 16)

            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.white)
        .safeAreaInset(edge: .bottom, spacing: 0) { summary }
        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 30, topTrailingRadius: 30))
        .presentationDragIndicator(.hidden)
        .presentationCornerRadius(30)
        .task {
            if viewModel.state.items.isEmpty { await loadBundles() }
        }
    }

    @ViewBuilder private var content: some View {
        if viewModel.state.isLoading {
            ProgressView("Loading bundles…")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let message = viewModel.state.errorMessage {
            VStack(spacing: 16) {
                Text(message)
                    .font(AppFont.regular(16))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(ink)
                Button("Try again") { Task { await loadBundles() } }
                    .tint(accent)
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if viewModel.state.isDataEmpty {
            Text("No bundle offers available")
                .font(AppFont.regular(17))
                .foregroundStyle(ink)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            HStack {
                Text(viewModel.state.selectSubjectTxt)
                    .font(AppFont.semi_bold(19))
                Spacer(minLength: 8)
                Button {
                    if viewModel.state.isSelectAll {
                        viewModel.deselectAllAction(offer: offer)
                    } else {
                        viewModel.selectAllAction(offer: offer)
                    }
                } label: {
                    HStack(spacing: 8) {
                        checkbox(selected: viewModel.state.isSelectAll)
                        Text("Select all").font(AppFont.regular(16))
                    }
                    .frame(minHeight: 44)
                }
                .buttonStyle(.plain)
                .disabled(viewModel.state.items.isEmpty)
                .accessibilityValue(viewModel.state.isSelectAll ? "Selected" : "Not selected")
            }
            .foregroundStyle(ink)
            .padding(.horizontal, 20)
            .padding(.bottom, 10)

            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.state.items.indices, id: \.self) { index in
                        bundleRow(at: index)
                    }
                    
                    Spacer()
                            .frame(height: 170)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
    }

    private func bundleRow(at index: Int) -> some View {
        let item = viewModel.state.items[index]
        return Button {
            viewModel.selectBundleAction(position: index, offer: offer)
        } label: {
            HStack(spacing: 28) {
                checkbox(selected: item.isSelected)
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.userBundle.item)
                        .font(AppFont.medium(16))
                        .foregroundStyle(Color.black)
                    HStack(spacing: 28) {
                        Text(price(item.userBundle.originalPrice))
                            .strikethrough()
                            .foregroundStyle(muted)
                        Text(price(item.userBundle.price))
                            .font(AppFont.bold(14))
                            .foregroundStyle(accent)
                    }
                    .font(AppFont.medium(14))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(18)
            .frame(maxWidth: .infinity, minHeight: 82, alignment: .leading)
            .background(Color.white, in: RoundedRectangle(cornerRadius: 14))
            .overlay {
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color(hex: "#EAEBEF"), lineWidth: 1)
            }
            .contentShape(RoundedRectangle(cornerRadius: 14))
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(item.userBundle.item), \(price(item.userBundle.price)), originally \(price(item.userBundle.originalPrice))")
        .accessibilityValue(item.isSelected ? "Selected" : "Not selected")
        .accessibilityAddTraits(item.isSelected ? [.isSelected] : [])
    }

    private func checkbox(selected: Bool) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 2)
                .fill(selected ? accent : Color.white)
            RoundedRectangle(cornerRadius: 2)
                .stroke(selected ? accent : muted, lineWidth: 1.8)
            if selected {
                Image(systemName: "checkmark")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
            }
        }
        .frame(width: 19, height: 19)
        .accessibilityHidden(true)
    }

    private var summary: some View {
        VStack(spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(viewModel.state.subjectSelectedTxt.isEmpty
                         ? "0 \(offer.offerType.lowercased())s selected"
                         : viewModel.state.subjectSelectedTxt)
                        .font(AppFont.regular(14))
                    Text("Bundle Total").font(AppFont.semi_bold(16))
                }
                .foregroundStyle(ink)
                Spacer(minLength: 8)
                VStack(alignment: .trailing, spacing: 3) {
                    Text(viewModel.state.bundlePriceTxt)
                        .font(AppFont.bold(20))
                        .foregroundStyle(accent)
                    Text(viewModel.state.originalPriceTxt)
                        .font(AppFont.regular(14))
                        .strikethrough()
                        .foregroundStyle(muted)
                }
            }
            Button {
                onContinue(viewModel.getSelectedBundles())
            } label: {
                Text("Continue")
                    .font(AppFont.bold(18))
                    .tracking(1)
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .overlay(alignment: .trailing) {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 19, weight: .medium))
                            .padding(.trailing, 24)
                    }
                    .foregroundStyle(viewModel.state.canContinue ? Color.white : Color(hex: "#9DA1A9"))
                    .background(viewModel.state.canContinue ? accent : Color(hex: "#E6E7EB"),
                                in: RoundedRectangle(cornerRadius: 13))
            }
            .buttonStyle(.plain)
            .disabled(!viewModel.state.canContinue || viewModel.state.isLoading || viewModel.state.errorMessage != nil)
        }
        .padding(.horizontal, 16)
        .padding(.top, 14)
        .padding(.bottom, 14)
        .background(Color(hex: "#FFF4F5").ignoresSafeArea(.container, edges: .bottom))
    }

    private func price(_ amount: Int) -> String {
        amount.formatted(.currency(code: "NGN").precision(.fractionLength(0)))
    }

    private func loadBundles() async {
        await viewModel.getBundles(buyerEmail: UserSettings.email ?? "", cbcId: offer.cbcId,
                                   level: offer.level, bundleId: bundleId, offer: offer)
    }
}

#Preview("No subjects selected") {
    bundlePreview(selected: false)
}

#Preview("Two subjects selected") {
    bundlePreview(selected: true)
}

@MainActor
private func bundlePreview(selected: Bool) -> some View {
    let offer = Offer(offerId: "2", offerType: "Subject", hasOffer: true,
                      cbcId: "1", level: "2", title: "JAMB & WAEC Lessons")
    let viewModel = BundleViewModel()
    viewModel.state.title = offer.title
    viewModel.state.description = "Select the subject you want and get access to all videos at discounted price"
    viewModel.state.selectSubjectTxt = "Select subjects"
    let subjects = [("English Language", 5000), ("Government", 11600),
                    ("Economics", 18000), ("Chemistry", 11800), ("Physics", 9800)]
    viewModel.state.items = subjects.enumerated().map { index, subject in
        BundleWithSelection(
            userBundle: UserBundle(item: subject.0, bundleId: String(index), price: 3500,
                                   originalPrice: subject.1, discountedPrice: 3500, sellerEmail: ""),
            isSelected: selected && (index == 1 || index == 2)
        )
    }
    viewModel.updateDynamicContent(offerType: offer.offerType)
    return BundleBottomSheetView(offer: offer, bundleId: nil, viewModel: viewModel, onContinue: {_ in }, onDismis: {})
}
