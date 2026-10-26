//
//  EarningsAgencyDetailsScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 20/10/2026.
//

import SwiftUI

struct EarningsAgencyDetailsScreen: View {
    
    let statement: EarningsCbtStatement
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text(transactionDate)
                    .font(AppFont.regular(14))
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 2)

                Grid(alignment: .topLeading, horizontalSpacing: 20, verticalSpacing: 30) {
                    detailRow("Title:", value: statement.exam_name)
                    detailRow("Price:", value: currency(statement.price))
                    detailRow("Transaction Income:", value: currency(statement.agent_income))
                    detailRow("Buyer:", value: statement.buyer_name)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
            .padding(.bottom, 32)
        }
        .foregroundStyle(.black)
        .background(Color.white)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Transaction Details")
                    .font(AppFont.semi_bold(18))
            }
        }
    }

    private func detailRow(_ label: String, value: String) -> some View {
        GridRow(alignment: .top) {
            Text(label)
                .font(AppFont.semi_bold(16))
            Text(value)
                .font(AppFont.regular(16))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .fixedSize(horizontal: false, vertical: true)
    }

    private func currency(_ value: String) -> String {
        guard let amount = Decimal(string: value) else { return "₦" + value }
        return "₦" + EarningsCbtFormatting.amount(amount)
    }

    private var transactionDate: String {
        let input = DateFormatter()
        input.locale = Locale(identifier: "en_US_POSIX")
        input.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = input.date(from: statement.created_at) else {
            return "On " + statement.created_at
        }
        let output = DateFormatter()
        output.locale = Locale(identifier: "en_US_POSIX")
        output.dateFormat = "'On' MMM d, yyyy 'at' hh:mm a"
        output.amSymbol = "am"
        output.pmSymbol = "pm"
        return output.string(from: date)
    }
}

#Preview {
    NavigationStack {
        EarningsAgencyDetailsScreen(statement: EarningsCbtStatement(
            id: "1", exam_id: "1", bundle_id: nil,
            buyer_email: "buyer@example.com", seller_email: "seller@example.com",
            agent_email: "agent@example.com", agent_income: "5", income: "60",
            reference: "preview", created_at: "2026-10-13 09:39:00",
            price: "100", commision: "0", is_android: "1", bundle_discount: "0",
            exam_name: "Education - JAMB & WAEC Lessons - English Language",
            buyer_name: "Toluwase"
        ))
    }
}
