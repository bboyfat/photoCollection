//
//  AddPhotoViewController.swift
//  TaskLessonSevenPhotoGallery
//
//  Created by Andrey Petrovskiy on 3/28/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameTextField: NSLayoutConstraint!
    
    @IBOutlet weak var cathegoryTextField: UITextField!
    
    @IBOutlet weak var deviceTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addPhotoFromCamera))
       // navigationItem
         let tapGest = UITapGestureRecognizer(target: self, action: #selector(addPhotoFromGallery))
        view.addGestureRecognizer(tapGest)
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
    @IBAction func saveBtn(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
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
