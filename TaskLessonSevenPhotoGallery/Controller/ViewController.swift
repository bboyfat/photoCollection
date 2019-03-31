//
//  ViewController.swift
//  TaskLessonSevenPhotoGallery
//
//  Created by Andrey Petrovskiy on 3/26/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIGestureRecognizerDelegate, AddPhotoDelegate {
    

    @IBOutlet var collectionView: UICollectionView!
    
    
   
    var categories: [Cat] = []
    var photos: [Photo] = []
    
    
    
//    var cat: Cat = Cat()
//    var photoModel: PhotoModel = PhotoModel()
    
    func fetchRequest(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Photo>(entityName: "Photo")
        do{
            let photos = try context.fetch(fetchRequest)
            photos.forEach { (photo) in
                
                for i in 0..<self.categories.count{
                    if self.categories[i].name == photo.category{
                    self.categories[i].data.append(photo)
                        self.collectionView.reloadData()
                        return
                    }
                    
                }
                addCategory(model: photo)
                print(self.categories.count)
                print("Fetch")
              
               
            }
        } catch let fetchErr{
            print("can't Fetch:", fetchErr)
        }
        
    }
    
    func didAddPhoto(model: Photo) {
        
        fetchRequest()
       
//        for i in 0..<self.categories.count{
//            if self.categories[i].name == model.category{
//                self.categories[i].data = photos
//                self.collectionView.reloadData()
//                return
//            }
//        }
//
    }
    func addCategory(model: Photo){
        let cat = Cat()
        guard let category = model.category else {
            return
        }
        cat.name = category
        cat.data.append(model)
        
        self.categories.append(cat)
        self.collectionView.reloadData()
    }
    
    func helloAlert(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "alertVC") as! MyAlertViewController
        
        present(vc, animated: true, completion: nil)
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
       helloAlert()
       fetchRequest()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhoto))
    }
    @objc func addPhoto(){
        let addPhotoVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addPhotoVC") as! AddPhotoViewController
        addPhotoVC.delegate = self

        let navigation = UINavigationController(rootViewController: addPhotoVC)
        present(navigation, animated: true, completion: nil)
    }

   
        
        
    }



extension ViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print(categories.count)
        return categories.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
       return categories[section].data.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoViewCell
        guard let image = categories[indexPath.section].data[indexPath.item].photo else {return cell}
        guard let photo = UIImage(data: image) else { return cell}
           cell.photoIV.image = photo

        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let supplView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! PhototHeaderRV
       
        supplView.titleLabel.text = categories[indexPath.section].name
        
        return supplView
    }
    
    
    
    
}

extension ViewController: UICollectionViewDelegate{
    
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        self.categories[indexPath.section].data.remove(at: indexPath.row)
         
        self.collectionView.deleteItems(at: [indexPath])

    }
    
    
    
    
}



extension ViewController: UICollectionViewDelegateFlowLayout{
    
}
