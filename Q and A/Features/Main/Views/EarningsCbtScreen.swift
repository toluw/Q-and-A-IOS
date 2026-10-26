import SwiftUI

struct EarningsCbtScreen: View {
    @ObservedObject var navVm: MainNavViewModel
    @StateObject private var viewModel = EarningsCbtViewModel()

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                if viewModel.state.isLoading && !viewModel.state.hasLoaded {
                    ProgressView("Loading earnings…")
                        .padding(.top, 48)
                        .frame(maxWidth: .infinity)
                } else if let message = viewModel.state.errorMessage {
                    ErrorView(message: message) {
                        Task { await viewModel.refresh() }
                    }
                    .padding(.vertical, 32)
                }

                if viewModel.state.isEmpty {
                    EmptyStateView(title: "You have no CBT earnings yet")
                        .padding(.top, 48)
                        .frame(maxWidth: .infinity)
                }

                ForEach(viewModel.state.days) { day in
                    Text(day.title)
                        .font(AppFont.regular(14))
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)

                    ForEach(day.statements) { statement in
                        NavigationLink {
                            EarningsCbtDetailsScreen(statement: statement)
                        } label: {
                            HStack(spacing: 16) {
                                Text(statement.exam_name)
                                    .font(AppFont.regular(16))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .fixedSize(horizontal: false, vertical: true)
                                Text("₦" + EarningsCbtFormatting.amount(Decimal(string: statement.income) ?? 0))
                                    .font(AppFont.regular(17))
                                    .foregroundStyle(Color(hex: "#FF7B6F"))
                                    .fixedSize()
                            }
                            .padding(16)
                            .frame(maxWidth: .infinity, minHeight: 68)
                            .background(Color(hex: "#F3F3F3"))
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        Divider()
                    }
                }
            }
        }
        .background(Color.white)
        .refreshable { await viewModel.refresh() }
        .task { await viewModel.loadInitial() }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            if viewModel.state.hasLoaded {
                HStack {
                    Text("Expected Payout")
                    Spacer()
                    Text("NGN" + EarningsCbtFormatting.amount(viewModel.state.income))
                        .foregroundStyle(Color(hex: "#00BE38"))
                }
                .font(AppFont.regular(18))
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
                .background(Color.white)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Earnings - CBT").font(AppFont.regular(18))
            }
        }
    }
}

#Preview {
    NavigationStack {
        EarningsCbtScreen(navVm: MainNavViewModel())
    }
}
