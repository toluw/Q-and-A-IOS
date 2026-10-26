//
//  EarningsCbtDetailsScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 20/10/2026.
//

import SwiftUI

struct EarningsCbtDetailsScreen: View {
    
    let statement: EarningsCbtStatement
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text(transactionDate)
                    .font(AppFont.regular(14))
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 2)

                VStack(alignment: .leading, spacing: 30) {
                    detailRow("Title:", value: statement.exam_name)
                    detailRow("Price:", value: currency(statement.price))
                    detailRow("Agent Income:", value: currency(statement.agent_income))
                    detailRow("Transaction Income:", value: currency(statement.income))
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
        HStack(alignment: .top, spacing: 20) {
            Text(label)
                .font(AppFont.semi_bold(16))
                .frame(width: 145, alignment: .leading)
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
    
    let statement = EarningsCbtStatement(id: "2",  exam_id: "1", bundle_id: "2", buyer_email: "oket@gm.com", seller_email: "bayo@yahoo.com", agent_email: nil, agent_income: "400", income: "200", reference: "ekjdk", created_at: "2026-10-18 12:51:16", price: "300", commision: "10", is_android: "1", bundle_discount: "2", exam_name: "walcott", buyer_name: "James Justin")
    CompatibleNavigationView {
        EarningsCbtDetailsScreen(statement: statement)
    }
}
