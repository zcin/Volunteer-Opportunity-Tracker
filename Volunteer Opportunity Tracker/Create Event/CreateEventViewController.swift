//
//  CreateEventViewController.swift
//  Volunteer Opportunity Tracker
//
//  Created by Cindy Zhang on 3/4/18.
//  Copyright © 2018 Cindy Zhang. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController, UITextFieldDelegate{
    
    let manager = EventsDataManager.sharedInstance

    @IBOutlet weak var eventNameInput: UITextField!
    @IBOutlet weak var locationInput: UITextField!
    @IBOutlet weak var addressInput: UITextField!
    @IBOutlet weak var photoInput: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eventNameInput.delegate = self
        locationInput.delegate = self
        addressInput.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text!)
    }
    
    @IBAction func submitButton(_ sender: UIButton) {
        let name = eventNameInput.text
        let location = locationInput.text
        let photo = photoInput.image
        
        if name == "" || location == "" || photo == UIImage(named: "Select") {
            print ("you didn't enter all information required")
        } else {
            let event = EventObject(name: name!, location: location!, photo: photo!)
            manager.addEvent(event)
            manager.saveEventsToArchive()
        }
        
        eventNameInput.text = ""
        locationInput.text = ""
        photoInput.image = UIImage(named: "Select")
    }
}

extension CreateEventViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //TODO: hide keyboard for whatever text field is currently being edited
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self // for this line, ui navigation controller delegate is necessary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoInput.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
}
