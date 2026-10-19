//
//  PortalScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 19/10/2026.
//

import SwiftUI
import UIKit

struct PortalScreen: View {
    @ObservedObject var navVm: MainNavViewModel
    @StateObject private var viewModel: PortalViewModel
    var onUpdateAccount: (() -> Void)? = nil
    var onEarnings: (() -> Void)? = nil

    @State private var copiedCode = false

    @MainActor
    init(navVm: MainNavViewModel, viewModel: PortalViewModel? = nil, onUpdateAccount: (() -> Void)? = nil, onEarnings: (() -> Void)? = nil) {
        self.navVm = navVm
        _viewModel = StateObject(wrappedValue: viewModel ?? PortalViewModel())
        self.onUpdateAccount = onUpdateAccount
        self.onEarnings = onEarnings
    }

    var body: some View {
        VStack(spacing: 0) {
            Button {
                onUpdateAccount?()
            } label: {
                HStack(spacing: 10) {
                    Spacer(minLength: 0)
                    Text("Update account number")
                        .font(AppFont.regular(16))
                    Image(systemName: "chevron.forward.2")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(Color(white: 0.82))
                }
                .padding(.horizontal, 16)
                .frame(minHeight: 64)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .disabled(onUpdateAccount == nil)
            .background(Color.white)
            .shadow(color: .black.opacity(0.10), radius: 4, y: 4)
            .zIndex(1)

            ScrollView {
                VStack(spacing: 24) {
                    if viewModel.state.isLoading {
                        ProgressView().padding(.top, 24)
                    } else if let message = viewModel.state.errorMessage {
                        ErrorView(message: message) {
                            Task { await viewModel.getPortalData() }
                        }
                    } else if viewModel.state.data != nil {
                        switch viewModel.state.agentState {
                        case .none:
                            EmptyView()
                        case .active(let code):
                            agentCard(code: code, isActive: true)
                        case .inactive(let code):
                            agentCard(code: code, isActive: false)
                        }

                        HStack(alignment: .top, spacing: 16) {
                            portalTile(title: "Payment History", image: "payment_history") {
                                navVm.navigate(route: .userPaymentScreen)
                            }
                            Spacer(minLength: 0)
                            portalTile(title: "Earnings", image: "earnings") {
                                onEarnings?()
                            }
                            .disabled(viewModel.state.data?.is_cbt_seller == false && viewModel.state.data?.is_agent == false)
                        }
                        .padding(.horizontal, 6)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 42)
                .frame(maxWidth: 600)
                .frame(maxWidth: .infinity)
            }
        }
        .foregroundStyle(Color.black)
        .background(Color(white: 0.965))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("My Portal").font(AppFont.semi_bold(20))
            }
        }
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onChange(of: viewModel.state.agentState) { _, _ in copiedCode = false }
        .task { await viewModel.loadInitial() }
    }

    private func agentCard(code: String, isActive: Bool) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Your agent code")
                        .font(AppFont.regular(16))
                        .foregroundStyle(Color(white: 0.4))
                    Text(code)
                        .font(AppFont.bold(26))
                        .tracking(2)
                        .foregroundStyle(isActive ? Color.black : Color(white: 0.46))
                        .textSelection(.enabled)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer(minLength: 0)
                if isActive {
                    Button {
                        UIPasteboard.general.string = code
                        copiedCode = true
                    } label: {
                        Label(copiedCode ? "Copied" : "Copy", systemImage: copiedCode ? "checkmark" : "square.on.square")
                            .font(AppFont.semi_bold(17))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .foregroundStyle(Color(red: 0.08, green: 0.45, blue: 0.16))
                            .background(Color(red: 0.83, green: 0.96, blue: 0.84), in: RoundedRectangle(cornerRadius: 12))
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(copiedCode ? "Agent code copied" : "Copy agent code")
                    .padding(.top, 22)
                } else {
                    Text("Inactive")
                        .font(AppFont.bold(14))
                        .foregroundStyle(Color(red: 0.75, green: 0.08, blue: 0.09))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(red: 1, green: 0.9, blue: 0.91), in: Capsule())
                }
            }
            Text(isActive ? "Share your code to earn commission" : "Your agent account is deactivated. This code cannot be used.")
                .font(AppFont.regular(14))
                .foregroundStyle(Color(white: isActive ? 0.4 : 0.46))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white, in: RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.10), radius: 3, y: 3)
    }

    private func portalTile(title: String, emoji: String? = nil, image: String? = nil, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 14) {
                if let image {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 46, height: 46)
                        .accessibilityHidden(true)
                } else if let emoji {
                    Text(emoji).font(.system(size: 40))
                        .frame(height: 46)
                        .accessibilityHidden(true)
                }
                Text(title)
                    .font(AppFont.regular(18))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 5)
            .padding(.vertical, 28)
            .frame(maxWidth: .infinity, minHeight: 132)
            .background(Color.white, in: RoundedRectangle(cornerRadius: 7))
            .shadow(color: .black.opacity(0.18), radius: 5, y: 5)
            .contentShape(RoundedRectangle(cornerRadius: 7))
        }
        .buttonStyle(.plain)
    }
}

#Preview("No agent") {
    NavigationStack {
        PortalScreen(navVm: MainNavViewModel(), viewModel: PortalViewModel(state: PortalState(data: PortalData(is_agent: false, is_cbt_seller: false, agent_code: nil, is_agent_active: false))))
    }
}

#Preview("Active agent") {
    NavigationStack {
        PortalScreen(navVm: MainNavViewModel(), viewModel: PortalViewModel(state: PortalState(data: PortalData(is_agent: true, is_cbt_seller: false, agent_code: "ABMLSY", is_agent_active: true))))
    }
}

#Preview("Inactive agent") {
    NavigationStack {
        PortalScreen(navVm: MainNavViewModel(), viewModel: PortalViewModel(state: PortalState(data: PortalData(is_agent: true, is_cbt_seller: false, agent_code: "ABJEH7", is_agent_active: false))))
    }
}
