//
//  GeminiFormattedView.swift
//  Q and A
//
//  Created by GIGL-PC on 24/06/2026.
//

import SwiftUI

struct GeminiFormattedView: View {
    
    let content: String

       var body: some View {

           ScrollView {

               VStack(alignment: .leading, spacing: 12) {

                   ForEach(
                       Array(content.parseGeminiContent().enumerated()),
                       id: \.offset
                   ) { _, segment in

                       switch segment {

                       case .text(let text):

                           Text(text.toBoldAttributedString())
                               .frame(
                                   maxWidth: .infinity,
                                   alignment: .leading
                               )

                       case .math(let latex):

                           MathView(latex: latex)
                               .frame(
                                   maxWidth: .infinity,
                                   alignment: .leading
                               )
                               .fixedSize(
                                   horizontal: false,
                                   vertical: true
                               )
                       }
                   }
               }
               .padding()
           }
       }
    
}

#Preview {
    GeminiFormattedView(content: "The correct answer is **D. dehydration**.\n\n### Explanation:\n\nThe production of ethene ($C_2H_4$) from ethanol ($C_2H_5OH$) is a classic example of an **elimination reaction**, specifically known as **dehydration**.\n\n**1. The Chemical Process:**\nDehydration is the removal of a water molecule ($H_2O$) from a compound. When ethanol is heated in the presence of a strong acid catalyst (such as concentrated sulfuric acid, $H_2SO_4$, or phosphoric acid, $H_3PO_4$), it loses a hydroxyl group ($-OH$) from one carbon atom and a hydrogen atom ($-H$) from the adjacent carbon atom.\n\n**2. The Chemical Equation:**\n$$C_2H_5OH(l) \\xrightarrow[170^\\circ\\text{C}]{\\text{conc. } H_2SO_4} C_2H_4(g) + H_2O(l)$$\n\n**3. Why the other options are incorrect:**\n*   **A. Decomposition:** While this involves breaking down a molecule, \"decomposition\" is a general term. Dehydration is the specific chemical mechanism used in this industrial and laboratory process.\n*   **B. Hydrolysis:** This is the reverse of dehydration; it involves the *addition* of water to break a chemical bond.\n*   **C. Ozonolysis:** This is a reaction where ozone ($O_3$) is used to break carbon-carbon double bonds in alkenes to form aldehydes or ketones. It is used to analyze or modify alkenes, not to produce them from alcohols.")
}
