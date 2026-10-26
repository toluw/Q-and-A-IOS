//
//  BundleCheckoutScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 16/10/2026.
//

import SwiftUI

struct BundleCheckoutScreen: View {
    @ObservedObject var cbtViewModel: CbtViewModel
    @StateObject var viewModel: BundleCheckoutViewModel = .init()
    @ObservedObject var navVm: MainNavViewModel
    @FocusState private var isCodeFocused: Bool
    @ObservedObject var paymentViewModel: PaymentViewModel

    private let ink = Color(hex: "#102044")
    private let coral = Color(hex: "#FF4348")
    private let green = Color(hex: "#0BA65B")
    private let blush = Color(hex: "#FFF6F6")

    var body: some View {
        VStack(spacing: 0) {
            
         ScrollView {
                VStack(spacing: 30) {
                    bundleSummary
                    if viewModel.state.hasAppliedCode {
                        appliedReferral
                        priceBreakdown
                            .padding(.top, -8)
                    } else {
                        referralInput
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 24)
            }
            .compatibleScrollDismissesKeyboard(.interactively)
        }
        .foregroundStyle(ink)
        .background(Color.white)
        .safeAreaInset(edge: .bottom) {
            Button(action: pay) {
                Text(viewModel.state.paymentText)
                    .font(AppFont.bold(16))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(coral, in: RoundedRectangle(cornerRadius: 13))
                    .shadow(color: .black.opacity(0.16), radius: 2, y: 2)
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 16)
            .background(Color.white)
        }
        .toolbar {
            
            // Title
            ToolbarItem(placement: .principal) {
                Text(cbtViewModel.offerTitle).font(AppFont.regular(18))
            }
            
            
        }
        .disabled(viewModel.state.showBlockedLoader)
        .overlay {
            if viewModel.state.showBlockedLoader {
                ZStack {
                    Color.black.opacity(0.25).ignoresSafeArea()
                    ProgressView("Applying referral code…")
                        .padding(24)
                        .background(.white, in: RoundedRectangle(cornerRadius: 16))
                }
            }
        }
        .onAppear {
            viewModel.setTotalPrice(bundles: cbtViewModel.selectedBundles)
            viewModel.updateViews()
        }
        .onCompatibleChange(of: viewModel.state.inputtedCode) { _, current in
            viewModel.onTextInputChanged(text: current)
        }
        .onCompatibleChange(of: viewModel.state.hasAppliedCode) { _, applied in
            if applied { isCodeFocused = false }
        }
    }

    private var bundleSummary: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Your bundle total")
                .font(AppFont.bold(18))
            Divider()
            HStack(spacing: 16) {
                VStack(spacing: 7) {
                    Text("Original Price").font(AppFont.regular(18))
                    Text(viewModel.state.originalPrice)
                        .font(AppFont.semi_bold(18))
                        .strikethrough()
                        .foregroundStyle(Color(hex: "#969DA8"))
                }
                .frame(maxWidth: .infinity)
                Rectangle().fill(ink.opacity(0.1)).frame(width: 1, height: 62)
                VStack(spacing: 7) {
                    Text("Bundle Price").font(AppFont.regular(18))
                    Text(viewModel.state.bundlePrice)
                        .font(AppFont.bold(18))
                        .foregroundStyle(coral)
                }
                .frame(maxWidth: .infinity)
            }
            HStack(spacing: 12) {
                Image(systemName: "tag.fill")
                Text(viewModel.state.bundleSavingsLabel)
                    .font(AppFont.semi_bold(15))
            }
            .foregroundStyle(green)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(14)
            .background(Color(hex: "#E5FAEE"), in: RoundedRectangle(cornerRadius: 10))
        }
        .padding(20)
        .background(blush, in: RoundedRectangle(cornerRadius: 17))
    }

    private var referralInput: some View {
        VStack(spacing: 24) {
            HStack(alignment: .center, spacing: 18) {
                Image(systemName: "tag.fill")
                    .font(.system(size: 32))
                    .foregroundStyle(coral)
                Text("Get additional discount\nwith referral code")
                    .font(AppFont.bold(16))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                Image(systemName: "chevron.up")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(coral)
                    .accessibilityHidden(true)
            }

            VStack(alignment: .leading, spacing: 8) {
                TextField("Enter referral code", text: $viewModel.state.inputtedCode)
                    .font(AppFont.regular(18))
                    .textInputAutocapitalization(.characters)
                    .autocorrectionDisabled()
                    .focused($isCodeFocused)
                    .submitLabel(.done)
                    .onSubmit { isCodeFocused = false }
                    .padding(16)
                    .background(.white, in: RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    .accessibilityLabel("Referral code")
                if !viewModel.state.inputError.isEmpty {
                    Text(viewModel.state.inputError)
                        .font(AppFont.regular(14))
                        .foregroundStyle(coral)
                }
            }
            .frame(maxWidth: 280)
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(blush, in: RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color(hex: "#F6DDDF")))
    }

    private var appliedReferral: some View {
        HStack(spacing: 20) {
            Image(systemName: "tag.fill")
                .font(.system(size: 34))
                .foregroundStyle(green)
            VStack(alignment: .leading, spacing: 8) {
                Text("Referral code applied!").font(AppFont.bold(17))
                Text(viewModel.state.agent?.code ?? "").font(AppFont.regular(16))
            }
            Spacer()
            Button(action: { viewModel.removeRefferal() }) {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 26, weight: .light))
                    .frame(width: 44, height: 44)
            }
            .accessibilityLabel("Remove referral code")
        }
        .padding(20)
        .background(Color(hex: "#E9FFF2"), in: RoundedRectangle(cornerRadius: 17))
    }

    private var priceBreakdown: some View {
        VStack(spacing: 22) {
            priceRow("Original Price", value: viewModel.state.originalPrice, crossedOut: true)
            priceRow("Bundle Price", value: viewModel.state.bundlePrice, crossedOut: true)
            priceRow("Referral Discount", value: viewModel.state.referralDiscount, color: green)
            Divider()
            HStack {
                Text("Total to Pay").font(AppFont.bold(18))
                Spacer()
                Text(viewModel.state.total).font(AppFont.bold(18)).foregroundStyle(coral)
            }
        }
        .padding(20)
        .background(Color(hex: "#F9FAFD"), in: RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color(hex: "#E8E9EF")))
    }

    private func priceRow(_ title: String, value: String, crossedOut: Bool = false, color: Color? = nil) -> some View {
        HStack {
            Text(title).font(AppFont.regular(15))
            Spacer()
            Text(value)
                .font(AppFont.bold(16))
                .strikethrough(crossedOut)
                .foregroundStyle(color ?? Color(hex: "#969DA8"))
        }
    }

    func pay() {
        cbtViewModel.agent = viewModel.state.agent
        paymentViewModel.paymentState = .initialize
        navVm.replaceTop(route: .bundlePaymentScreen)
    }
}

#Preview {
    BundleCheckoutScreen(cbtViewModel: CbtViewModel(), navVm: MainNavViewModel(), paymentViewModel: PaymentViewModel())
}
