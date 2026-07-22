//
//  ImagePicker.swift
//  Q and A
//
//  Created by GIGL-PC on 22/07/2026.
//

import Foundation

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {

    let sourceType: UIImagePickerController.SourceType
    let completion: (UIImage?) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {

        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator

        return picker
    }

    func updateUIViewController(
        _ uiViewController: UIImagePickerController,
        context: Context
    ) {
    }

    class Coordinator: NSObject,
                       UINavigationControllerDelegate,
                       UIImagePickerControllerDelegate {

        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {

            let image = info[.originalImage] as? UIImage

            picker.dismiss(animated: true)

            parent.completion(image)

        }

        func imagePickerControllerDidCancel(
            _ picker: UIImagePickerController
        ) {

            picker.dismiss(animated: true)

            parent.completion(nil)

        }

    }

}
