import SwiftUI

struct PaymentRecievedAgencyScreen: View {
    @ObservedObject var navVm: MainNavViewModel

    var body: some View {
        PaymentReceivedHistoryScreen(kind: .agency)
    }
}

#Preview {
    NavigationStack {
        PaymentRecievedAgencyScreen(navVm: MainNavViewModel())
    }
}
