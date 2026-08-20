//
//  PaymentCardView.swift
//  Q and A
//
//  Created by GIGL-PC on 20/08/2026.
//

import SwiftUI

import SwiftUI

struct PaymentCardView: View {
    let payment: Payment
    let onClick: () -> Void

    private var formattedPrice: String {
        guard let value = Double(payment.price) else { return "₦\(payment.price)" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.maximumFractionDigits = 2
        let formatted = formatter.string(from: NSNumber(value: value)) ?? payment.price
        return "₦\(formatted)"
    }

    private var formattedDate: String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // adjust to match your API's actual format
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")

        guard let date = inputFormatter.date(from: payment.createdAt) else {
            return payment.createdAt
        }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM d, yyyy • h:mm a"
        return outputFormatter.string(from: date)
    }

    private var processorIcon: String {
        switch payment.processor {
        case "1": return "creditcard.fill"
        case "3": return "applelogo"
        case "2": return "g.circle.fill"
        default: return "creditcard"
        }
    }

    private var typeColor: Color {
        switch payment.type.lowercased() {
        case "book": return Color(hex: "#4A90D9")
        case "video": return Color(hex: "#E85D75")
        case "cbt": return Color(hex: "#4CAF7D")
        default: return Color(hex: "#8E8E93")
        }
    }

    var body: some View {
        
        Button(action: onClick){
            
            HStack(spacing: 12) {
                // Type indicator
                RoundedRectangle(cornerRadius: 4)
                    .fill(typeColor)
                    .frame(width: 4)

                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(payment.type.capitalized)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(typeColor)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(typeColor.opacity(0.12))
                            .cornerRadius(6)

                        Spacer()

                        Text(formattedPrice)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color(hex: "#1A1A1A"))
                    }

                    Text("Ref: \(payment.reference)")
                        .font(.system(size: 13))
                        .foregroundColor(Color(hex: "#6B6B6B"))
                        .lineLimit(1)

                    HStack(spacing: 6) {
                        Image(systemName: processorIcon)
                            .font(.system(size: 12))
                            .foregroundColor(Color(hex: "#8E8E93"))

                        Text(payment.paymentProcessor)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Color(hex: "#6B6B6B"))

                        Text("•")
                            .foregroundColor(Color(hex: "#C7C7CC"))

                        Text(formattedDate)
                            .font(.system(size: 12))
                            .foregroundColor(Color(hex: "#8E8E93"))
                    }
                }
                .padding(.vertical, 12)

                Spacer()
            }
            .padding(.horizontal, 14)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
            .contentShape(Rectangle())
            
        }.buttonStyle(.plain)
        
       
        
        
    }
}

// Hex color helper (skip if you already have one in your project)


// Usage in a List
struct PaymentListView: View {
    let payments: [Payment] = [Payment.preview, Payment.preview, Payment.preview]

    var body: some View {
        
        ZStack{
            
            LazyVStack(spacing: 16){
                
                ForEach(payments, id: \.id){payment in
                    PaymentCardView(payment: payment, onClick: {})
                }
                
            }.padding(.horizontal, 16)
            
        /*    List(payments, id: \.id) { payment in
                PaymentCardView(payment: payment)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
            }
         
         */
         
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("list_bg"))
    }
}

#Preview {
  //  PaymentCardView(payment: Payment.preview)
    PaymentListView()
}
