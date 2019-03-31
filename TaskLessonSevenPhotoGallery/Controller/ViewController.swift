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
    
    
    func didEdtiPhoto(model: Photo) {
        for i in 0..<self.categories.count{
        let item = self.photos.index(of: model)
       let reloadPath = IndexPath(item: item!, section: i)
            self.collectionView.reloadItems(at: [reloadPath])
    }
    }
    
    
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
        

       
         for i in 0..<self.categories.count{
            if self.categories[i].name == model.category{
                self.categories[i].data.append(model)
                self.collectionView.reloadData()
                return
            }
        }
       
        addCategory(model: model)
        self.collectionView.reloadData()
        

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
        
        let alert = UIAlertController(title: "EDITING", message: nil, preferredStyle: .actionSheet)
        
        let editAction = UIAlertAction(title: "Edit", style: .default) { (_) in
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addPhotoVC") as! AddPhotoViewController
            let navController = UINavigationController(rootViewController: vc)
            vc.delegate = self
            
            
            self.present(navController, animated: true, completion: nil)
            
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
             let photo = self.categories[indexPath.section].data[indexPath.item]
            
            let context = CoreDataManager.shared.persistentContainer.viewContext
            
                
            
            self.categories[indexPath.section].data.remove(at: indexPath.row)
            
            self.collectionView.deleteItems(at: [indexPath])
                
                context.delete(photo)
            do{
                try context.save()
                
            } catch let delErr{
                print("Unnable to delete..", delErr)
            }
            
            }

        
        
        
        alert.addAction(editAction)
        alert.addAction(deleteAction)
        present(alert, animated: true, completion: nil)

        
    }
    
    
    
    
}



extension ViewController: UICollectionViewDelegateFlowLayout{
    
}
