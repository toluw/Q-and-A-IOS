import SwiftUI

struct PaymentRecievedAgencyScreen: View {
    @ObservedObject var navVm: MainNavViewModel

    var body: some View {
        PaymentReceivedHistoryScreen(kind: .agency)
    }
}

#Preview {
    CompatibleNavigationView {
        PaymentRecievedAgencyScreen(navVm: MainNavViewModel())
    }
}
