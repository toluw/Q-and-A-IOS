import SwiftUI

/// Present over a dimmed background, with dismissal owned by the presenter.
struct TakeActionDialogView: View {
    let price: Int
    let onProceedToPay: () -> Void
    let onAddToCart: () -> Void
    var onDismiss: () -> Void = {}

    private var formattedPrice: String {
        "₦" + price.formatted(.number.precision(.fractionLength(0...2)))
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button(action: onDismiss) {
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(Color(hex: "#777777"))
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                .accessibilityLabel("Close")
            }
            .padding(.trailing, 12)
            .padding(.top, 12)

            Text("Choose an action")
                .font(AppFont.bold(22))
                .multilineTextAlignment(.center)
                .padding(.top, 4)
                .accessibilityAddTraits(.isHeader)

            VStack(spacing: 12) {
                Text("Total amount")
                    .font(AppFont.regular(17))
                    .foregroundColor(Color(hex: "#777777"))

                Text(formattedPrice)
                    .font(AppFont.bold(28))
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 30)

            VStack(spacing: 12) {
                Button(action: onProceedToPay) {
                    Text("Proceed to pay")
                        .font(AppFont.semi_bold(16))
                        .tracking(1)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 56)
                        .background(Color(hex: "#F23D49"))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: .black.opacity(0.16), radius: 2, y: 2)
                }

                Button(action: onAddToCart) {
                    Text("Add to cart")
                        .font(AppFont.semi_bold(16))
                        .tracking(1)
                        .frame(maxWidth: .infinity, minHeight: 56)
                        .contentShape(RoundedRectangle(cornerRadius: 15))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(hex: "#999999"), lineWidth: 1)
                        )
                }
            }
            .padding(.top, 32)
            .padding(.horizontal, 26)
            .padding(.bottom, 26)
        }
        .buttonStyle(.plain)
        .foregroundColor(Color(hex: "#222222"))
        .frame(maxWidth: 360)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .padding(.horizontal, 24)
    }
}

#Preview {
    ZStack {
        Color.black.opacity(0.45).ignoresSafeArea()
        TakeActionDialogView(price: 200, onProceedToPay: {}, onAddToCart: {})
    }
}
