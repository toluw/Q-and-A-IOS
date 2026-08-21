//
//  PaymentDetailsScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 21/08/2026.
//

import SwiftUI

struct PaymentDetailsScreen: View {
    
    
    @StateObject private var viewModel = PaymentDetailsViewModel()
    let payment: Payment
    
    
    
    var body: some View {
        
        ScrollView {
                   VStack(alignment: .leading, spacing: 20) {
                       summaryCard

                       Text("Items in this purchase")
                           .font(.system(size: 13, weight: .semibold))
                           .foregroundColor(Color(hex: "#6B6B6B"))
                           .padding(.horizontal, 4)

                       itemsSection
                   }
                   .padding(16)
               }
               .background(Color(hex: "#F5F5F7"))
               .navigationTitle("Payment details")
               .navigationBarTitleDisplayMode(.inline)
               .onAppear{
                   viewModel.getPaymentDetails(type: payment.type, reference: payment.reference)
               }
               
        
    }
    
    // MARK: - Summary card

       private var summaryCard: some View {
           VStack(alignment: .leading, spacing: 0) {
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
                       .font(.system(size: 24, weight: .bold))
                       .foregroundColor(Color(hex: "#1A1A1A"))
               }

               Text(formattedDate)
                   .font(.system(size: 13))
                   .foregroundColor(Color(hex: "#8E8E93"))
                   .padding(.top, 8)

               Divider()
                   .padding(.vertical, 14)

               detailRow(icon: "number", label: "Reference", value: payment.reference)
               detailRow(icon: "creditcard", label: "Processor", value: payment.processor)
               detailRow(icon: "envelope", label: "Email", value: payment.email)
           }
           .padding(18)
           .background(Color.white)
           .cornerRadius(12)
           .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
       }
    
    
    private func detailRow(icon: String, label: String, value: String) -> some View {
           HStack {
               Label(label, systemImage: icon)
                   .font(.system(size: 13))
                   .foregroundColor(Color(hex: "#6B6B6B"))
               Spacer()
               Text(value)
                   .font(.system(size: 13))
                   .foregroundColor(Color(hex: "#1A1A1A"))
                   .lineLimit(1)
           }
           .padding(.vertical, 5)
       }

       // MARK: - Items section

       @ViewBuilder
       private var itemsSection: some View {
           switch viewModel.state.loadState{
           case .loading:
               VStack(spacing: 12) {
                   ProgressView()
                   Text("Loading items…")
                       .font(.system(size: 13))
                       .foregroundColor(Color(hex: "#8E8E93"))
               }
               .frame(maxWidth: .infinity)
               .padding(.vertical, 32)

           case .empty:
               Text("No items found for this payment.")
                   .font(.system(size: 13))
                   .foregroundColor(Color(hex: "#8E8E93"))
                   .frame(maxWidth: .infinity)
                   .padding(.vertical, 32)

           case .error(let message):
               VStack(spacing: 10) {
                   Text(message)
                       .font(.system(size: 13))
                       .foregroundColor(Color(hex: "#8E8E93"))
                       .multilineTextAlignment(.center)
                   Button("Retry") {
                       viewModel.getPaymentDetails(type: payment.type, reference: payment.reference)}
                   }
                .font(.system(size: 13, weight: .semibold))
               .frame(maxWidth: .infinity)
               .padding(.vertical, 24)

           case .loaded(let items):
               LazyVStack(spacing: 8) {
                   ForEach(items, id: \.self) { item in
                       itemRow(item)
                   }
               }
           }
       }
    
    
    private func itemRow(_ item: String) -> some View {
          HStack(spacing: 10) {
              Image(systemName: iconForType)
                  .font(.system(size: 16))
                  .foregroundColor(typeColor)

              Text(item)
                  .font(.system(size: 14))
                  .foregroundColor(Color(hex: "#1A1A1A"))

              Spacer()
          }
          .padding(.horizontal, 14)
          .padding(.vertical, 12)
          .background(Color.white)
          .cornerRadius(8)
          .overlay(
              RoundedRectangle(cornerRadius: 8)
                  .stroke(Color(hex: "#E5E5EA"), lineWidth: 0.5)
          )
      }
    
    
    private var formattedPrice: String {
         guard let value = Double(payment.price) else { return "₦\(payment.price)" }
         let formatter = NumberFormatter()
         formatter.numberStyle = .decimal
         formatter.groupingSeparator = ","
         formatter.maximumFractionDigits = 2
         return "₦\(formatter.string(from: NSNumber(value: value)) ?? payment.price)"
     }

     private var formattedDate: String {
         let inputFormatter = DateFormatter()
         inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
         inputFormatter.locale = Locale(identifier: "en_US_POSIX")
         guard let date = inputFormatter.date(from: payment.createdAt) else { return payment.createdAt }
         let outputFormatter = DateFormatter()
         outputFormatter.dateFormat = "MMM d, yyyy • h:mm a"
         return outputFormatter.string(from: date)
     }

     private var typeColor: Color {
         switch payment.type.lowercased() {
         case "book": return Color(hex: "#4A90D9")
         case "video": return Color(hex: "#E85D75")
         case "cbt": return Color(hex: "#4CAF7D")
         default: return Color(hex: "#8E8E93")
         }
     }

     private var iconForType: String {
         switch payment.type.lowercased() {
         case "book": return "book.fill"
         case "video": return "play.rectangle.fill"
         case "cbt": return "doc.text.fill"
         default: return "doc.fill"
         }
     }
}

#Preview {
    PaymentDetailsScreen(payment: Payment.preview)
}
