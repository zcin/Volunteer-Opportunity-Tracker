//
//  CreateEventViewController.swift
//  Volunteer Opportunity Tracker
//
//  Created by Cindy Zhang on 3/4/18.
//  Copyright © 2018 Cindy Zhang. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController, UITextFieldDelegate{
    
    var manager:EventsDataManager!

    @IBOutlet weak var eventNameInput: UITextField!
    @IBOutlet weak var locationInput: UITextField!
    @IBOutlet weak var addressInput: UITextField!
    @IBOutlet weak var descriptionInput: UITextView!
    @IBOutlet weak var photoInput: UIImageView!
    
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var startTimeField: UITextField!
    @IBOutlet weak var endTimeField: UITextField!
    
    
    let datePickerView:UIDatePicker = UIDatePicker()
    var dateTimeFieldEdited:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = EventsDataManager.sharedInstance
        
        descriptionInput.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        descriptionInput.layer.borderWidth = 1.0
        descriptionInput.layer.cornerRadius = 5
        
        
        createDatePicker()
    }
    
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePickingDate))
        toolbar.setItems([done], animated: false)
        
        dateField.inputAccessoryView = toolbar
        startTimeField.inputAccessoryView = toolbar
        endTimeField.inputAccessoryView = toolbar
    }
    
    @IBAction func dateFieldEditing(_ sender: UITextField) {
        if sender.accessibilityIdentifier! == "date" { datePickerView.datePickerMode = UIDatePickerMode.date }
        else { datePickerView.datePickerMode = UIDatePickerMode.time }
        sender.inputView = datePickerView
        dateTimeFieldEdited = sender.accessibilityIdentifier!
    }
    
    @objc func donePickingDate() {
        let dateFormatter = DateFormatter()
        if dateTimeFieldEdited == "date" {
            dateFormatter.dateStyle = DateFormatter.Style.medium
            dateFormatter.timeStyle = DateFormatter.Style.none
            dateField.text = dateFormatter.string(from: datePickerView.date)
            dateField.endEditing(true)
        }
            
        else {
            dateFormatter.dateStyle = DateFormatter.Style.none
            dateFormatter.timeStyle = DateFormatter.Style.short
            
            if dateTimeFieldEdited == "startTime" {
                startTimeField.text = dateFormatter.string(from: datePickerView.date)
                startTimeField.endEditing(true)
            } else if dateTimeFieldEdited == "endTime" {
                endTimeField.text = dateFormatter.string(from: datePickerView.date)
                endTimeField.endEditing(true)
            }
        }
    }
    
    @IBAction func submitButton(_ sender: UIButton) {
        let name = eventNameInput.text
        let location = locationInput.text
        let address = addressInput.text
        let description = descriptionInput.text
        let date = dateField.text
        let startTime = startTimeField.text
        let endTime = endTimeField.text
        let photo = photoInput.image
        
        if name == "" || location == "" || address == "" || description == "" || date == "" || startTime == "" || endTime == "" || photo == UIImage(named: "Select") {
            print ("you didn't enter all information required")
        } else {
            let event = EventObject(name: name!, location: location!, address: address!, description: description!, date: date!, startTime: startTime!, endTime: endTime!)
            manager.addEventToDatabase(event, photo!)
        }
        
        eventNameInput.text = ""
        locationInput.text = ""
        addressInput.text = ""
        descriptionInput.text = ""
        dateField.text = ""
        startTimeField.text = ""
        endTimeField.text = ""
        photoInput.image = UIImage(named: "Select")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
