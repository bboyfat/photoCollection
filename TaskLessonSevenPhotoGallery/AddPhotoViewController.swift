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
    
    
    
    var model: PhotoModel = PhotoModel()
    var category: Cat? 
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print(category)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addPhotoFromCamera))
       
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
        
        guard let image = imageView.image else {return}
         let date = Date()
        guard let device = deviceTextField.text else {return}
        guard let name = nameTextField.text else {return}
        guard let category = cathegoryTextField.text else {return}
        
            if let cat = self.category{
            
        self.model.photo = image
        self.model.date = date
        self.model.device = device
        self.model.name = name
            print(model)
        cat.name = category
        cat.data.insert(model, at: 0)
        
        self.delegate?.didAddPhoto(cat: cat)
            }
          
        dismiss(animated: true) {}
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

