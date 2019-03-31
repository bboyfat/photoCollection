//
//  AddPhotoViewController.swift
//  TaskLessonSevenPhotoGallery
//
//  Created by Andrey Petrovskiy on 3/28/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import CoreData

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    
    
    var delegate: AddPhotoDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var cathegoryTextField: UITextField!
    
    @IBOutlet weak var deviceTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    
    
//    var model: PhotoModel = PhotoModel()
   
    var photoModel: Photo?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        guard let image = imageView!.image else {return}
        guard let data = image.pngData() else {return}
        
        guard let device = deviceTextField.text else {return}
        guard let name = nameTextField.text else {return}
        guard let category = cathegoryTextField.text else {return}
        
        
        
            
//        self.model.photo = image
//        self.model.date = Date()
//        self.model.device = device
//        self.model.name = name
//        self.model.category = category
//            print(model)
        
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let photo = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: context)
        
        photo.setValue(category, forKey: "category")
        photo.setValue(device, forKey: "device")
         photo.setValue(name, forKey: "name")
         photo.setValue(data, forKey: "photo")
         photo.setValue(Date(), forKey: "date")
        
        
        do{
            try context.save()
            if let photoModel = photoModel{
                self.delegate?.didAddPhoto(model: photoModel) }
        } catch let saveErr{
            print("Can't save: ", saveErr)
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

