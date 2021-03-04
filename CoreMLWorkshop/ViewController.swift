//
//  ViewController.swift
//  CoreMLWorkshop
//
//  Created by Anderson David on 3/3/21.
//

import UIKit
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var chosenImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // var model = CNNEmotions()
    var model = SqueezeNetInt8LUT()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeImage(_ sender: Any) {
        getImage()
    }
    
    func getImage() {
        let picker = UIImagePickerController()
        
//        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
//            picker.sourceType = .camera
//        }
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            print("No image chosen!")
            return
        }
        
        chosenImage.image = image
        dismiss(animated: true)
        
        do {
            let vnModel = try VNCoreMLModel(for: model.model)
            let request = VNCoreMLRequest(model: vnModel) { (request, error) in
                guard let results = request.results as? [VNClassificationObservation] else {
                    print("An error occurred!")
                    return
                }
                // Assigns the first result (if it exists) to firstObject
                guard let firstObject = results.first else {
                    print("An error occurred!")
                    return
                }
                
                self.descriptionLabel.text = "(Value: \(firstObject.identifier), Confidence: \(firstObject.confidence))"
            }
            
            let imageData = image.jpegData(compressionQuality: 0.5)
            try VNImageRequestHandler(data: imageData!, options: [:]).perform([request])
        }
        catch {
            print("An error occurred!")
        }
    }
    
}

