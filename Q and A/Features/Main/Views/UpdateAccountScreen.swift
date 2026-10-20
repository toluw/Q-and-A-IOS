import SwiftUI

struct UpdateAccountScreen: View {
    @StateObject private var viewModel = UpdateAccountViewModel()
    @State private var showBanks = false
    @FocusState private var focusedField: Field?

    private enum Field: Hashable { case name, number }

    var body: some View {
        ScrollView {
            VStack(spacing: 36) {
                Image("qanda")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .accessibilityHidden(true)

                Text("Update your account details for receiving payments")
                    .font(AppFont.regular(18))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)

                if viewModel.isLoading {
                    ProgressView("Loading account details…")
                        .frame(maxWidth: .infinity)
                } else if let error = viewModel.loadError {
                    ErrorView(message: error) {
                        Task { await viewModel.loadInitial() }
                    }
                } else if viewModel.hasLoaded {
                    accountForm
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 32)
            .frame(maxWidth: 600)
            .frame(maxWidth: .infinity)
        }
        .background(Color.white)
        .foregroundStyle(Color.black)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .scrollDismissesKeyboard(.interactively)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") { focusedField = nil }
            }
        }
        .sheet(isPresented: $showBanks) {
            BankBottomSheetView { bank in
                viewModel.bank = bank
                showBanks = false
            }
        }
        .alert("Account updated", isPresented: Binding(
            get: { viewModel.successMessage != nil },
            set: { if !$0 { viewModel.successMessage = nil } }
        )) {
            Button("OK", role: .cancel) { viewModel.successMessage = nil }
        } message: {
            Text(viewModel.successMessage ?? "")
        }
        .task { await viewModel.loadInitial() }
    }

    private var accountForm: some View {
        VStack(spacing: 36) {
            outlinedField("Account Name") {
                TextField("Account name", text: $viewModel.accountName)
                    .textInputAutocapitalization(.words)
                    .autocorrectionDisabled()
                    .focused($focusedField, equals: .name)
                    .submitLabel(.next)
                    .onSubmit { focusedField = .number }
            }

            outlinedField("Account Number") {
                TextField("Account number", text: $viewModel.accountNumber)
                    .keyboardType(.numberPad)
                    .focused($focusedField, equals: .number)
            }

            outlinedField("Account type") {
                Menu {
                    ForEach(BankAccountType.allCases, id: \.self) { type in
                        Button(type.rawValue) {
                            focusedField = nil
                            viewModel.accountType = type
                        }
                    }
                } label: {
                    selectionLabel(viewModel.accountType?.rawValue ?? "Select account type")
                }
                .accessibilityLabel("Account type")
                .accessibilityValue(viewModel.accountType?.rawValue ?? "Not selected")
            }

            outlinedField("Bank") {
                Button {
                    focusedField = nil
                    showBanks = true
                } label: {
                    selectionLabel(viewModel.bank.isEmpty ? "Select bank" : viewModel.bank)
                }
                .accessibilityLabel("Bank")
                .accessibilityValue(viewModel.bank.isEmpty ? "Not selected" : viewModel.bank)
            }

            if let error = viewModel.errorMessage {
                Text(error)
                    .font(AppFont.regular(14))
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .accessibilityAddTraits(.updatesFrequently)
            }

            Button {
                focusedField = nil
                Task { await viewModel.save() }
            } label: {
                HStack(spacing: 12) {
                    if viewModel.isSaving { ProgressView().tint(.white) }
                    Text(viewModel.isSaving ? "Saving…" : "Save")
                        .font(AppFont.medium(18))
                }
                .frame(maxWidth: .infinity, minHeight: 56)
                .foregroundStyle(.white)
                .background(Color.black, in: RoundedRectangle(cornerRadius: 4))
            }
            .padding(.top, 12)
        }
        .buttonStyle(.plain)
        .disabled(viewModel.isSaving)
    }

    private func selectionLabel(_ value: String) -> some View {
        HStack(spacing: 12) {
            Text(value)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 0)
            Image(systemName: "chevron.down")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity, minHeight: 28)
        .contentShape(Rectangle())
    }

    private func outlinedField<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
        content()
            .font(AppFont.regular(18))
            .padding(.horizontal, 16)
            .padding(.vertical, 18)
            .frame(maxWidth: .infinity, minHeight: 64, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.gray.opacity(0.7), lineWidth: 1)
            }
            .overlay(alignment: .topLeading) {
                Text(title)
                    .font(AppFont.regular(14))
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 4)
                    .background(Color.white)
                    .offset(x: 12, y: -10)
            }
    }
}

#Preview {
    NavigationStack { UpdateAccountScreen() }
}
