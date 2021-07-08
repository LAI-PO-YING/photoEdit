//
//  ViewController+Extension.swift
//  photoEdit
//
//  Created by 賴柏穎 on 2021/7/7.
//

import UIKit

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIColorPickerViewControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        photoImageView.image = info[.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        containerView.backgroundColor = viewController.selectedColor
        changeViewBackgroundColorButton.backgroundColor = viewController.selectedColor
    }
}
