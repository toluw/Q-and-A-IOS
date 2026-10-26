
import SwiftUI

/// Persistent collapsed bundle offering.
/// Place inside a parent's bottom safe-area inset.
struct BundleOfferingView: View {

    // Retained for compatibility with existing calls.
    let offerType: String
    let onExpand: () -> Void

    private let backgroundColor = Color(hex: "#FFF1F1")
    private let primaryRed = Color(hex: "#FF4545")
    private let navy = Color(hex: "#102452")
    private let subtitleColor = Color(hex: "#53627E")

    var body: some View {
        Button(action: onExpand) {

            VStack(spacing: 14) {

                // MARK: - Header
                HStack(spacing: 12) {

                    // Discount icon
                    Image(systemName: "tag.fill")
                        .font(.system(size: 28))
                        .foregroundStyle(primaryRed)
                        .frame(width: 36, height: 36)
                        .accessibilityHidden(true)

                    // Title and subtitle
                    VStack(alignment: .leading, spacing: 4) {

                        Text("Save More With Bundles")
                            .font(AppFont.semi_bold(18))
                            .foregroundStyle(navy)
                            .lineLimit(2)

                        Text("Get multiple \(offerType.lowercased())s at discounted prices.")
                            .font(AppFont.regular(14))
                            .foregroundStyle(subtitleColor)
                            .fixedSize(
                                horizontal: false,
                                vertical: true
                            )
                    }
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    .multilineTextAlignment(.leading)

                    // Expand indicator
                    Image(systemName: "chevron.up")
                        .font(.system(
                            size: 16,
                            weight: .bold
                        ))
                        .foregroundStyle(primaryRed)
                        .frame(width: 40, height: 40)
                        .background(.white, in: Circle())
                        .accessibilityHidden(true)
                }

                // MARK: - CTA
                HStack(spacing: 8) {

                    Text("View Discounted Bundles")
                        .font(AppFont.semi_bold(16))

                    Image(systemName: "arrow.right")
                        .font(.system(
                            size: 16,
                            weight: .semibold
                        ))
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(
                    primaryRed,
                    in: RoundedRectangle(cornerRadius: 12)
                )
            }
            .padding(.horizontal, 20)
            .padding(.top, 18)
            .padding(.bottom, 16)
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .background {
            CompatibleRoundedRectangle(
                topLeadingRadius: 24,
                topTrailingRadius: 24
            )
            .fill(backgroundColor)
            .shadow(
                color: .black.opacity(0.10),
                radius: 12,
                x: 0,
                y: -4
            )
            .ignoresSafeArea(
                .container,
                edges: .bottom
            )
        }
        .zIndex(1)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(
            "Save More With Bundles. Get multiple subjects at discounted prices."
        )
        .accessibilityHint(
            "Double tap to view discounted bundles"
        )
    }
}


#Preview("Persistent bundle offering") {
    ScrollView {
        VStack(spacing: 20) {
            ForEach(10..<16) { topic in
                Text("Topic \(topic) - Biology")
                    .font(AppFont.semi_bold(20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(24)
                    .background(.white, in: RoundedRectangle(cornerRadius: 24))
            }
        }
        .padding(16)
    }
    .background(Color(hex: "#F5F5F5"))
    .safeAreaInset(edge: .bottom, spacing: 0) {
        
        BundleOfferingView(offerType:"Subject", onExpand: {})
        
       
    }
}


#Preview("Bundle Offering View"){
    BundleOfferingView(offerType:"Subject", onExpand: {
        
    })
}
