//
//  ViewController.swift
//  Seafood
//
//  Created by Abrish Sabri on 9/11/19.
//  Copyright © 2019 Abrish Sabri. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedimage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
             imageView.image = userPickedimage
            
            guard let ciimage = CIImage(image: userPickedimage) else {
                fatalError("Could not conver UIImage to CIImage")
            }
            detect(image: ciimage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(image: CIImage){
        self.navigationItem.title = "Detecting..."
        guard let model = try? VNCoreMLModel(for: MobileNet().model) else {
            fatalError("Loading CoreML Model Failed.")
        }
        
        let request = VNCoreMLRequest(model: model, completionHandler: {
            request, error in
            
            guard let results = request.results as? [VNClassificationObservation] else { fatalError("Model failed to process Image")}
            
            if let firstResult = results.first{
                //self.navigationItem.title = firstResult.identifier
                if firstResult.identifier.contains("keyboard") {
                    self.navigationItem.title = "Keyboard!"
                } else {
                    self.navigationItem.title = "Not a keyboard!"
                }
            } else {
                self.navigationItem.title = "Could not find anything!"
            }
        })
        
        let handler = VNImageRequestHandler(ciImage: image)
             do {
                 try handler.perform([request])
             } catch {
                 print(error)
             }
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    
    }

}
