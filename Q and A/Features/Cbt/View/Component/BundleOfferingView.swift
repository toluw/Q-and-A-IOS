import SwiftUI

/// The collapsed bundle offering. Pin it in a parent's bottom safe-area inset
/// and use `onExpand` to present the available bundles.
struct BundleOfferingView: View {
    
    let offerType: String
    
    let onExpand: () -> Void

    private let backgroundColor = Color(hex: "#FFF1F3")
    

    var body: some View {
        Button(action: onExpand) {
            HStack(spacing: 16) {
                BundleGiftIcon()
                    .frame(width: 44, height: 52)
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Save more with Bundles")
                        .font(AppFont.semi_bold(20))

                    Text("Get complete subject packages at discounted prices.")
                        .font(AppFont.regular(16))
                        .fixedSize(horizontal: false, vertical: true)
                }
                .foregroundStyle(Color.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .layoutPriority(1)

                Image(systemName: "chevron.up")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color(hex: "#FF525B"))
                    .frame(width: 44, height: 44)
                    .background(.white, in: Circle())
                    .accessibilityHidden(true)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 24)
            .frame(maxWidth: .infinity, minHeight: 110)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .background {
            UnevenRoundedRectangle(topLeadingRadius: 28, topTrailingRadius: 28)
                .fill(backgroundColor)
                .shadow(color: .black.opacity(0.10), radius: 12, x: 0, y: -4)
                .ignoresSafeArea(.container, edges: .bottom)
        }
        .zIndex(1)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Save more with Bundles. Get complete \(offerType.lowercased()) packages at discounted prices.")
        .accessibilityHint("Shows available bundles")
    }
}

private struct BundleGiftIcon: View {
    private let ribbonColor = Color(hex: "#FFCF32")

    var body: some View {
        ZStack {
            // Bow loops meet at the ribbon above the lid.
            Ellipse()
                .stroke(ribbonColor, lineWidth: 4)
                .frame(width: 17, height: 10)
                .rotationEffect(.degrees(40))
                .offset(x: -8, y: -19)

            Ellipse()
                .stroke(ribbonColor, lineWidth: 4)
                .frame(width: 17, height: 10)
                .rotationEffect(.degrees(-40))
                .offset(x: 8, y: -19)

            RoundedRectangle(cornerRadius: 2)
                .fill(Color(hex: "#FF4355"))
                .frame(width: 36, height: 32)
                .offset(y: 10)

            Rectangle()
                .fill(Color(hex: "#F52D45"))
                .frame(width: 18, height: 32)
                .offset(x: 9, y: 10)

            RoundedRectangle(cornerRadius: 2)
                .fill(Color(hex: "#FF5363"))
                .frame(width: 44, height: 10)
                .offset(y: -8)

            Rectangle()
                .fill(ribbonColor)
                .frame(width: 7, height: 44)
                .offset(y: 4)
        }
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
