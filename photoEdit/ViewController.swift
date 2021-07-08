//
//  ViewController.swift
//  photoEdit
//
//  Created by 賴柏穎 on 2021/7/7.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var changeViewBackgroundColorButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    
    
    let aDergree = CGFloat.pi / 180
    var rotateAngle: CGFloat = 0
    var scaleX: CGFloat = 1
    var scaleY: CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func pickPhoto(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        let alert = UIAlertController(title: "Choose the photo from", message: nil, preferredStyle: .actionSheet)
        let showLibraryAction = UIAlertAction(title: "Album", style: .default) { ACTION in
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true, completion: {
                self.guideLabel.isHidden = true
                self.containerView.backgroundColor = .white
                self.changeViewBackgroundColorButton.backgroundColor = .white
            })
        }
        let showCameraAction = UIAlertAction(title: "Camera", style: .default) { ACTION in
            imagePickerController.sourceType = .camera
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        let actions: [UIAlertAction] = [
            showLibraryAction,
            showCameraAction,
            cancelAction
        ]
        for action in actions {
            alert.addAction(action)
        }
        
        present(alert, animated: true, completion: nil)
 
    }
    @IBAction func ratioAdjustSegmentedControl(_ sender: UISegmentedControl) {
        
        let length: CGFloat = 374
        let width = length
        var height: CGFloat
        switch sender.selectedSegmentIndex {
//      1:1
        case 0:
            height = length
//      16:9
        case 1:
            height = length / 16 * 9
//      10:8
        case 2:
            height = length / 10 * 8
//      7:5
        case 3:
            height = length / 7 * 5
//      4:3
        case 4:
            height = length / 4 * 3
//      1:1
        default:
            height = length
        }
        photoImageView.bounds.size = CGSize(width: width, height: height)
    }
    
    
    @IBAction func rotateRight(_ sender: UIButton) {
        rotateAngle += aDergree * 90
        photoImageView.transform = CGAffineTransform(rotationAngle: rotateAngle).scaledBy(x: scaleX, y: scaleY)
        if rotateAngle == aDergree * 360 {
            rotateAngle = 0
        }
    }
    
    @IBAction func rotateLeft(_ sender: UIButton) {
        rotateAngle -= aDergree * 90
        photoImageView.transform = CGAffineTransform(rotationAngle: rotateAngle).scaledBy(x: scaleX, y: scaleY)
        if rotateAngle == aDergree * -360 {
            rotateAngle = 0
        }
    }
    

    @IBAction func mirror(_ sender: UIButton) {
        if rotateAngle == 0 || rotateAngle == aDergree * 180 || rotateAngle == aDergree * -180 {
            scaleX *= -1
            photoImageView.transform = CGAffineTransform(rotationAngle: rotateAngle).scaledBy(x: scaleX, y: scaleY)
        }
        else if rotateAngle == aDergree * 90 || rotateAngle == aDergree * -90 || rotateAngle == aDergree * 270 || rotateAngle == aDergree * -270{
            scaleY *= -1
            photoImageView.transform = CGAffineTransform(rotationAngle: rotateAngle).scaledBy(x: scaleX, y: scaleY)
        }
    }
    @IBAction func changeViewBackgroundColor(_ sender: UIButton) {
        let colorPickerViewControlor = UIColorPickerViewController()
        colorPickerViewControlor.delegate = self
        present(colorPickerViewControlor, animated: true, completion: nil)
        
    }
    
    @IBAction func addText(_ sender: UITextField) {
        textLabel.text = sender.text
    }
    @IBAction func savePhoto(_ sender: UIButton) {
        let renderer = UIGraphicsImageRenderer(size: containerView.bounds.size)
        let image = renderer.image(actions: {
            (context) in containerView.drawHierarchy(in: containerView.bounds, afterScreenUpdates: true)
        })
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    
}

