//
//  ViewController.swift
//  FirstApplicationRepo
//
//  Created by Srinivasa Ravi Teja Peri on 7/1/19.
//  Copyright © 2019 HarshaRaviGitHub. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    @IBOutlet weak var ratingControl: RatingControl!
    

    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil);
    }
    
    var meal : Meal?
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for:segue, sender:sender);
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self;
        
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
// Do any additional setup after loading the view.
        updateSaveButtonState()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState();
        navigationItem.title = textField.text;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false;
    }
    
    private func updateSaveButtonState() {
        let text = nameTextField.text ?? "";
        saveButton.isEnabled = !text.isEmpty;
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder();
        let imagePickerController = UIImagePickerController();
        imagePickerController.sourceType = .photoLibrary;
        imagePickerController.delegate = self;
        present(imagePickerController, animated: true, completion: nil);
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as?
        UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        photoImageView.image = selectedImage;
        dismiss(animated: true, completion: nil);
    }
}

