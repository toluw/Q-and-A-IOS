import SwiftUI

struct PaymentReceivedCbtScreen: View {
    @ObservedObject var navVm: MainNavViewModel

    var body: some View {
        PaymentReceivedHistoryScreen(kind: .cbt)
    }
}

struct PaymentReceivedHistoryScreen: View {
    let kind: PayoutHistoryKind
    @StateObject private var viewModel: PaymentReceivedCbtViewModel

    init(kind: PayoutHistoryKind) {
        self.kind = kind
        _viewModel = StateObject(wrappedValue: PaymentReceivedCbtViewModel(kind: kind))
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                if viewModel.state.isLoading && !viewModel.state.hasLoaded {
                    ProgressView("Loading payouts…")
                        .padding(.top, 24)
                        .frame(maxWidth: .infinity)
                } else if let message = viewModel.state.errorMessage {
                    ErrorView(message: message) {
                        Task { await viewModel.refresh() }
                    }
                    .padding(.vertical, 24)
                }

                if viewModel.state.isEmpty {
                    EmptyStateView(title: kind.emptyTitle)
                        .padding(.top, 24)
                        .frame(maxWidth: .infinity)
                }

                ForEach(Array(viewModel.state.payouts.enumerated()), id: \.offset) { _, payout in
                    HStack(alignment: .top, spacing: 16) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Received")
                                .font(AppFont.regular(17))
                                .foregroundStyle(.black)
                            Text(payout.formattedDate)
                                .font(AppFont.regular(14))
                                .foregroundStyle(.gray)
                        }
                        Spacer(minLength: 0)
                        Text("₦" + payout.formattedAmount)
                            .font(AppFont.medium(17))
                            .foregroundStyle(Color(hex: "#66AD68"))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex: "#F3F3F3"))
                }
            }
            .padding(.top, 26)
            .padding(.bottom, 16)
        }
        .background(Color.white)
        .refreshable { await viewModel.refresh() }
        .task { await viewModel.loadInitial() }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            if viewModel.state.hasLoaded {
                HStack {
                    Text("Total Payout")
                        .foregroundStyle(.black)
                    Spacer()
                    Text("NGN" + viewModel.state.income)
                        .foregroundStyle(Color(hex: "#FF7B6F"))
                }
                .font(AppFont.medium(18))
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
                .background(Color.white)
                .overlay(alignment: .top) { Divider() }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(kind.title)
                    .font(AppFont.semi_bold(18))
            }
        }
    }
}

#Preview {
    NavigationStack {
        PaymentReceivedCbtScreen(navVm: MainNavViewModel())
    }
}
