import SwiftUI

struct WhatsappCommunityBottomSheetView: View {
    let whatsappCommunity: WhatsappCommunity

    @Environment(\.dismiss) private var dismiss

    private let navy = Color(red: 0.04, green: 0.06, blue: 0.28)
    private let whatsappGreen = Color(red: 0.02, green: 0.39, blue: 0.20)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 12) {
                    Image("whatsapp")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .frame(width: 44, height: 44)
                        .background(Color(red: 0.85, green: 0.95, blue: 0.88))
                        .cornerRadius(10)
                        .accessibilityHidden(true)

                    Text("WHATSAPP COMMUNITY")
                        .font(AppFont.semi_bold(13))
                        .tracking(1)
                }
                .padding(.bottom, 18)

                Text(whatsappCommunity.title ?? "")
                    .font(AppFont.bold(20))
                    .fixedSize(horizontal: false, vertical: true)
                    .accessibilityAddTraits(.isHeader)
                    .padding(.bottom, 10)

                Text(whatsappCommunity.message ?? "")
                    .font(AppFont.regular(16))
                    .foregroundColor(Color(red: 0.34, green: 0.35, blue: 0.39))
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 28)

                VStack(spacing: 10) {
                    Button(action: {
                        // Join behavior will be connected in a follow-up.
                    }) {
                        Text("Join on WhatsApp")
                            .frame(maxWidth: .infinity, minHeight: 48)
                            .foregroundColor(.white)
                            .background(whatsappGreen)
                            .cornerRadius(10)
                    }

                    Button(action: { dismiss() }) {
                        Text("Not now")
                            .frame(maxWidth: .infinity, minHeight: 48)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(navy, lineWidth: 1.5)
                            )
                    }
                }
                .font(.system(.title3, design: .default).weight(.bold))
                .buttonStyle(.plain)
            }
            .foregroundColor(navy)
            .padding(.horizontal, 20)
            .padding(.top, 28)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.ignoresSafeArea())
        .compatiblePresentationDetents([.height(380), .large])
        .compatiblePresentationDragIndicator(.visible)
        .compatiblePresentationCornerRadius(24)
    }
}

#Preview {
    WhatsappCommunityBottomSheetView(
        whatsappCommunity: WhatsappCommunity(
            show_notification: true,
            reason: "Exam preparation",
            traction_id: nil,
            community_id: nil,
            offer_id: nil,
            title: "2027 UTME & WAEC Exam Prep",
            link: nil,
            message: "Study with other students preparing for their exams.",
            views_since_last_notice: nil,
            views_remaining: nil
        )
    )
}
