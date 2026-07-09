//
//  PdfLoaderScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 09/07/2026.
//

import SwiftUI

struct PdfLoaderScreen: View {

    let remoteURL: URL

    @StateObject
    private var vm = PdfLoaderViewModel()
    
    @ObservedObject var navVm: MainNavViewModel

    var body: some View {

        VStack(spacing: 20) {
            
            Text("Hang On. Content available shortly..")
                .font(AppFont.regular(14))

            ProgressView(value: vm.progress)
                .progressViewStyle(.linear)

            Text("\(Int(vm.progress*100))%")

            if let error = vm.error {

                Text(error)

                Button("Retry") {

                    vm.start(url: remoteURL)

                }

            }

        }
        .padding()
        .task {

            vm.start(url: remoteURL)

        }
        .onReceive(vm.$completedURL.compactMap{$0}) { url in

            
        
            print("complete \(url)")

            
           navVm.replaceTop(route: .pdfReaderScreen(fileUrl: url))
              

        }

    }

}
#Preview {
    PdfLoaderScreen(remoteURL: URL(string: "https://example.com/sample.pdf")!, navVm: MainNavViewModel())
}
