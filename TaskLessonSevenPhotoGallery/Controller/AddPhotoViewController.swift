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
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var cathegoryTextField: UITextField!
    
    @IBOutlet weak var deviceTextField: UITextField!
    
   
    
    
    
   
   
    var photoModel: Photo?{
        didSet{
           self.datePicker?.date = photoModel?.date ?? Date()
        
            guard let imageData = photoModel?.photo else { return }
            if let image = UIImage(data: imageData){
            self.imageView?.image = image
            }
            self.nameTextField?.text = photoModel?.name
            self.deviceTextField?.text = photoModel?.device
            self.cathegoryTextField?.text = photoModel?.category
    }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = photoModel == nil ? "Add Photo": "Edit Photo"
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addPhotoFromCamera))
       
         navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhotoFromGallery))
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        
        view.addGestureRecognizer(tap)
        
    }
    @objc func addPhotoFromGallery(){
        
        presentPickerController(sourceType: .photoLibrary)

    }
    @objc func addPhotoFromCamera(){
        
        presentPickerController(sourceType: .camera)

    }
    func presentPickerController(sourceType: UIImagePickerController.SourceType){
        
         let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    @objc func endEditing(){
        view.endEditing(true)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
        if photoModel != nil{
            updatePhoto()
        } else {
           
             addNewPhoto()
        }
     
            
        
  }
    private func updatePhoto(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        photoModel?.date = datePicker.date
        photoModel?.device = deviceTextField.text
        photoModel?.category = cathegoryTextField.text
        photoModel?.name = nameTextField.text
        if let imageData = imageView.image?.pngData(){
        photoModel?.photo = imageData
        }
        do{
            try context.save()
            if let photoModel = self.photoModel{
            self.delegate?.didEdtiPhoto(model: photoModel)
            }
            dismiss(animated: true, completion: nil)
        } catch let updErr{
            print("Can't update", updErr)
        }
    }
    
   private func addNewPhoto(){
        guard let image = imageView!.image else {return}
        guard let data = image.pngData() else {return}
        
        guard let device = deviceTextField.text else {return}
        guard let name = nameTextField.text else {return}
        guard let category = cathegoryTextField.text else {return}
        
        
        
        
        
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let photo = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: context)
        let date = datePicker.date
        photo.setValue(category, forKey: "category")
        photo.setValue(device, forKey: "device")
        photo.setValue(name, forKey: "name")
        photo.setValue(data, forKey: "photo")
        photo.setValue(date, forKey: "date")
        let photoModel = photo as! Photo
        
        do{
            try context.save()
            self.delegate?.didAddPhoto(model: photoModel)
            dismiss(animated: true)
            
            
            
        } catch let saveErr{
            print("Can't save: ", saveErr)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editingImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            imageView.image = editingImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
        
             imageView.image = originalImage
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
   

}

