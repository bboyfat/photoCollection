//
//  AddPhotoViewController.swift
//  TaskLessonSevenPhotoGallery
//
//  Created by Andrey Petrovskiy on 3/28/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    
    
    var delegate: AddPhotoDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var cathegoryTextField: UITextField!
    
    @IBOutlet weak var deviceTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    var model: PhotoModel?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addPhotoFromCamera))
       // navigationItem
         navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhotoFromGallery))
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        
        view.addGestureRecognizer(tap)
        
    }
    @objc func addPhotoFromGallery(){
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    @objc func addPhotoFromCamera(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = self
         present(imagePickerController, animated: true, completion: nil)
    }
    @objc func endEditing(){
        view.endEditing(true)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        model?.photo = imageView.image!
        model?.date = Date()
        model?.device = deviceTextField.text!
        model?.name = nameTextField.text!
        
        dismiss(animated: true) {
            self.delegate?.didAddPhoto(model: self.model!)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
   

}
