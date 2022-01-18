//
//  ViewController.swift
//  CoreMLWorkshop
//
//  Created by Anderson David on 3/3/21.
//

import UIKit
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    // Outlets for the image and label showing ML Model's output 
    @IBOutlet weak var chosenImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // To switch models, switch which of the two lines below are commented out.
    // var model = CNNEmotions()
    var model = SqueezeNetInt8LUT()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    /* changeImage() - Reacts to user click on imageView */
    @IBAction func changeImage(_ sender: Any) {
        getImage()
    }
    
    /* getImage() - Function called to present imagePicker to user */
    func getImage() {
        // Create a picker view controller
        let picker = UIImagePickerController()
        
        // If you want user to supply image from camera, un-comment out the below if-statement
        // Otherwise, the image will be chosen from user's photo library
//        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
//            picker.sourceType = .camera
//        }
        
        // allow user's to crop the chosen photo
        picker.allowsEditing = true
        
        // set delegate to self, indicating that this View Controller will implement necessary functions for picker
        picker.delegate = self
        
        // present the picker view to user
        present(picker, animated: true)
    }
    
    /* imagePickerController(..., didFinishPickingMediaWithInfo, ...) - Function required for imagePicker implementation, determines what to do once user has supplied an image */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Make sure user has supplied an image, if not return
        guard let image = info[.editedImage] as? UIImage else {
            print("No image chosen!")
            return
        }
        
        // Set the imageView to display chosen image
        chosenImage.image = image
        
        // Dismiss the imagePicker now that image has been selected
        dismiss(animated: true)
        
        // Below is code for sending a request to the CoreML model
        do {
            
            // Create a VNCoreMLModel with the supplied model
            let vnModel = try VNCoreMLModel(for: model.model)
            
            // Create a VNCoreMLRequest with the model supplied above,
            // and also provide a completion handler that specifies what to do
            // once the request returns information and/or error
            let request = VNCoreMLRequest(model: vnModel) { (request, error) in
                
                // Check that the request actually returned a result
                guard let results = request.results as? [VNClassificationObservation] else {
                    print("An error occurred!")
                    return
                }
                
                // Check that there is a "first result," which indicates the ML model's
                // classification with highest confidence
                guard let firstObject = results.first else {
                    print("An error occurred!")
                    return
                }
                
                // setup the label to display the model's "first result" prediction with highest confidence
                self.descriptionLabel.text = "(Value: \(firstObject.identifier)\n Confidence: \(firstObject.confidence))"
            }
            
            
            // The CoreML models expect jpegData rather than a UIImage, so
            // extract the jpegData from the user's chosen image
            let imageData = image.jpegData(compressionQuality: 0.5)
            
            // Perform the request defined above, supplying the imageData
            try VNImageRequestHandler(data: imageData!, options: [:]).perform([request])
        }
        catch {
            // Since many of the CoreML operations above can throw errors, we place it in a do-catch
            // to make sure the app does not crash on error
            print("An error occurred!")
            self.descriptionLabel.text = "Error!"
        }
    }
    
}

