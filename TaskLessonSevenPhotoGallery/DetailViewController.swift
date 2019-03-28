//
//  DetailViewController.swift
//  TaskLessonSevenPhotoGallery
//
//  Created by Andrey Petrovskiy on 3/26/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
   
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var deviceTextField: UITextField!
    
    
    var photoModel: PhotoModel?
    
    @IBAction func saveData(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
      super.viewDidLoad()
        setupText()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didFinish))
        view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc func didFinish(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setupText(){
        
        guard let imagePath = photoModel?.photo else { return }
        guard let imageName = photoModel?.name else {return}
        guard let device = photoModel?.device else { return }
       print(imagePath, imageName, device)
        
        imageView?.image = UIImage(named: imagePath)
        nameTextField?.text = imageName
        deviceTextField?.text = device
        categoryTextField?.text = "category"
        dateTextField?.text = "21 21 21"
    }
  
    

    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
