//
//  PhotoPicker.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/17.
//

import Foundation
import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
    
    @Binding var companyImage: UIImage
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let photoPicker: PhotoPicker
        
        init(photoPicker: PhotoPicker) {
            self.photoPicker = photoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                guard let data = image.jpegData(compressionQuality: 0.2), let compressedImage = UIImage(data: data) else { return }
                photoPicker.companyImage = image
            } else {
                // show alert
            }
            picker.dismiss(animated: true)
        }
    }
}

