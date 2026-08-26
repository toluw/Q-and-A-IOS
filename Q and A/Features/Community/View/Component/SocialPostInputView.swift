//
//  SocialPostInputView.swift
//  Q and A
//
//  Created by GIGL-PC on 16/07/2026.
//

import SwiftUI

struct SocialPostInputView: View {
    
    @Binding var text: String
    let label: String
    let quote: Reply?
    
    @Binding var requestFocus: Bool
    
    @State private var selectedImage: UIImage?
    @State private var base64Image: String?

    @State private var showSourcePicker = false
    @State private var showImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary

    @State private var convertingImage = false
    
    @FocusState private var isTextFocused: Bool

    let onSubmit: (_ text: String, _ imageBase64: String?) -> Void
    let onCloseQuote: () -> Void

    private var canSubmit: Bool {
           !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

       var body: some View {
           VStack(spacing: 8) {
               
               Divider()
                   .background(LessonColor.border)
               
               
               if let replyQuote = quote{
                   
                   QuoteView(name: replyQuote.user.name, content: replyQuote.content, onClose: onCloseQuote)
                   
               }

               TextEditor(text: $text)
                   .focused($isTextFocused)
                   .frame(minHeight: 30, maxHeight: 60)
                   .scrollContentBackground(.hidden)
                   .padding(.horizontal, 4)
                   .overlay(alignment: .topLeading) {
                       if text.isEmpty {
                           Text(label)
                               .foregroundStyle(.gray)
                               .padding(.top, 12)
                               .padding(.leading, 8)
                               .allowsHitTesting(false)
                       }
                   }

               HStack {

                  imageButton

                   Spacer()

                   Button {
                       let value = text.trimmingCharacters(in: .whitespacesAndNewlines)
                       onSubmit(value, base64Image)
                       text = ""
                       selectedImage = nil
                       base64Image = nil
                       isTextFocused = false 
                   } label: {
                       Image("post_btn")
                           .renderingMode(.template)
                           .font(.title3)
                   }
                   .disabled(!canSubmit)
                   .foregroundStyle(canSubmit ? .blue : .gray.opacity(0.5))
               }
               .padding(.horizontal, 4)
           }
           .padding(10)
           .confirmationDialog(
                       "Choose Image",
                       isPresented: $showSourcePicker
                   ) {

                       if UIImagePickerController.isSourceTypeAvailable(.camera) {

                           Button("Camera") {

                               sourceType = .camera
                               showImagePicker = true

                           }

                       }

                       Button("Photo Library") {

                           sourceType = .photoLibrary
                           showImagePicker = true

                       }

                   }
                   .onChange(of: requestFocus) { _, newValue in
                                  isTextFocused = newValue
                              }
                    .onChange(of: isTextFocused) { _, newValue in
                                  requestFocus = newValue
                              }
                   .sheet(isPresented: $showImagePicker) {

                       ImagePicker(
                           sourceType: sourceType
                       ) { image in

                           guard let image else {
                               return
                           }

                           convertToBase64(image)

                       }

                   }
           
       }
    
    
    @ViewBuilder
       private var imageButton: some View {

           if convertingImage {

               ProgressView()
                   .frame(width: 32, height: 32)

           } else if let image = selectedImage {

               Button {

                   showSourcePicker = true

               } label: {

                   Image(uiImage: image)
                       .resizable()
                       .scaledToFill()
                       .frame(width: 36, height: 36)
                       .clipShape(RoundedRectangle(cornerRadius: 6))

               }

           } else {

               Button {

                   showSourcePicker = true

               } label: {

                   Image(systemName: "photo")
                       .font(.title2)

               }

           }

       }
    
    
    private func convertToBase64(_ image: UIImage) {

        convertingImage = true

        Task.detached {

            // Compress to 50% quality
            let imageData = image.jpegData(compressionQuality: 0.5)

            let base64 = imageData?.base64EncodedString()

            await MainActor.run {
                self.selectedImage = image
                self.base64Image = base64
                self.convertingImage = false
            }
        }
    }
    
}

#Preview {
    SocialPostInputPreviewWrapper(text: "", label: "Join the conversation", requestFocus: true)
}


struct SocialPostInputPreviewWrapper: View {
    
    
    
    @State var text: String
    @State var requestFocus: Bool
    let label: String
    
    init(text: String, label: String, requestFocus: Bool) {
        self.text = text
        self.label = label
        self.requestFocus = requestFocus
    }
    

    var body: some View{
        
        SocialPostInputView(text: $text, label: label, quote: Reply.preview, requestFocus: $requestFocus, onSubmit: {text, tx in}, onCloseQuote: {} )
        
    }
    
    
    
}


