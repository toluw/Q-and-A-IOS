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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    
    let statement = EarningsCbtStatement(id: "2",  exam_id: "1", bundle_id: "2", buyer_email: "oket@gm.com", seller_email: "bayo@yahoo.com", agent_email: nil, agent_income: "400", income: "200", reference: "ekjdk", created_at: "2026-10-18 12:51:16", price: "300", commision: "10", is_android: "1", bundle_discount: "2", exam_name: "walcott", buyer_name: "James Justin")
    EarningsCbtDetailsScreen(statement: statement)
}
