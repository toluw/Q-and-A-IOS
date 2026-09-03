//
//  MarketplaceProductScreen.swift
//  Q and A
//
//  Improved version — consistent card design across loading / error / loaded states,
//  custom purchase card instead of default ProductView styling.
//

import SwiftUI
import StoreKit

struct MarketplaceProductScreen: View {

    let price: Int
    @StateObject var viewModel: MarketPlaceProductViewModel = MarketPlaceProductViewModel()

    @ObservedObject var paymentViewModel: PaymentViewModel
    @ObservedObject var navVm: MainNavViewModel

    @Environment(\.openURL) private var openURL

    private var whatsappSupportURL: URL {
        let message = "Hi, I'm having trouble purchasing the ₦\(price) marketplace content from my IOS device"
        let encoded = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return URL(string: "https://wa.me/2347052193183?text=\(encoded)")
            ?? URL(string: "https://wa.me/2347052193183")!
    }

    var productid: String {
        "ng.qanda.purchase.\(price)"
    }

    var body: some View {
        VStack(spacing: 0) {

            header

            Spacer(minLength: 24)

            content
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 24)

            Spacer()
        }
        .task {
            await viewModel.loadProducts(productId: productid)
        }
        .onChange(of: viewModel.successPaymentReference) { previous, current in
            if let reference = viewModel.successPaymentReference {
                paymentViewModel.paymentState = .success(reference: reference, processor: 3)
                navVm.pop()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    paymentViewModel.paymentState = .cancel
                    navVm.pop()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.primary)
                        .frame(width: 30, height: 30)
                        .background(Color(.systemGray6), in: Circle())
                }
            }
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(spacing: 6) {
            Text("Purchase Marketplace Content")
                .font(AppFont.medium(16))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Text("₦\(price)")
                .font(AppFont.bold(30))
        }
        .padding(.top, 24)
        .padding(.horizontal, 16)
    }

    // MARK: - Content per state

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            loadingCard

        case .error:
            unavailableCard

        case .loaded(let product):
            purchaseCard(for: product)
        }
    }

    // MARK: - Loading

    private var loadingCard: some View {
        VStack(spacing: 16) {
            ProgressView()
                .controlSize(.large)

            Text("Loading payment options…")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 48)
    }

    // MARK: - Unavailable / price point not created

    private var unavailableCard: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.orange.opacity(0.12))
                    .frame(width: 72, height: 72)

                Image(systemName: "clock.badge.exclamationmark")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundStyle(.orange)
            }
            .padding(.top, 8)

            Text("This price point isn't available yet")
                .font(AppFont.medium(17))
                .multilineTextAlignment(.center)

            Text("We're still setting up ₦\(price) purchases. Please check back shortly, or try a different amount.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)

            Button {
                openURL(whatsappSupportURL)
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "message.fill")
                    Text("Contact Support")
                        .font(AppFont.medium(15))
                }
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .tint(.primary)
            .padding(.top, 4)

            Button {
                paymentViewModel.paymentState = .cancel
                navVm.pop()
            } label: {
                Text("Go Back")
                    .font(AppFont.medium(15))
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                    .padding(.vertical, 12)
            }
            .buttonStyle(.bordered)
        }
        .padding(20)
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    // MARK: - Loaded / purchase card

    private func purchaseCard(for product: Product) -> some View {
        VStack(spacing: 20) {
            ZStack {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color.primary.opacity(0.06))
                    .frame(width: 72, height: 72)

                Image(systemName: "bag.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.primary)
            }

            VStack(spacing: 6) {
                Text(product.displayName)
                    .font(AppFont.medium(18))
                    .multilineTextAlignment(.center)

                Text(product.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Divider()

            HStack {
                Text("Total")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Spacer()

                Text(product.displayPrice)
                    .font(AppFont.bold(17))
            }

            purchaseButton(for: product)
        }
        .padding(20)
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private func purchaseButton(for product: Product) -> some View {
        Button {
            Task {
                await viewModel.purchase(product)
            }
        } label: {
            HStack {
                if viewModel.isPurchasing {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text("Pay \(product.displayPrice)")
                        .font(AppFont.medium(16))
                }
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
            .padding(.vertical, 14)
        }
        .buttonStyle(.borderedProminent)
        .disabled(viewModel.isPurchasing)
    }
}

#Preview {
    MarketplaceProductScreen(price: 100, paymentViewModel: PaymentViewModel(), navVm: MainNavViewModel())
}
