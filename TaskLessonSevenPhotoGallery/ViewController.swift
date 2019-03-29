//
//  ViewController.swift
//  TaskLessonSevenPhotoGallery
//
//  Created by Andrey Petrovskiy on 3/26/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate, AddPhotoDelegate {
    

    @IBOutlet var collectionView: UICollectionView!
    
    
   
    var categories: [Cat] = []
    var cat: Cat = Cat()
//    var photoModel: PhotoModel = PhotoModel()
    
    func didAddPhoto(cat: Cat) {
        if self.categories.isEmpty{
            self.categories.append(cat)
        } else {
            for i in 0..<self.categories.count{
                self.categories.insert(cat, at: i)
            }
        }
        self.collectionView.reloadData()
    }
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()


        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhoto))
    }
    @objc func addPhoto(){
        let addPhotoVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addPhotoVC") as! AddPhotoViewController
        addPhotoVC.delegate = self
      addPhotoVC.category = self.cat
//        addPhotoVC.model = self.photoModel
        let navigation = UINavigationController(rootViewController: addPhotoVC)
        present(navigation, animated: true, completion: nil)
    }

    @objc func showAction(sender: UILongPressGestureRecognizer){
        if sender.state == UIGestureRecognizer.State.began {
            
            let touchPoint = sender.location(in: self.view)
            if let indexPath = collectionView.indexPathForItem(at:touchPoint) {
                
                let cont = UIAlertController(title: "Photo", message: nil, preferredStyle: .actionSheet)
                let act = UIAlertAction(title: "Delete", style: .destructive, handler: nil)
                let edit = UIAlertAction(title: "Edit", style: .default) { (action) in
                    
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
                    

                    let navController = UINavigationController(rootViewController: vc)
                    self.present(navController, animated: true, completion: nil)
                   
                    
                }
                cont.addAction(edit)
                cont.addAction(act)
                print("gesture!")
                present(cont, animated: true, completion: nil)
        }
        
        
    }
    }

}


extension ViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print(categories.count)
        return categories.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       print(categories[section].data.count)
       return categories[section].data.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoViewCell
        
           cell.photoIV.image = categories[indexPath.section].data[indexPath.item].photo

        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(showAction))
        cell.addGestureRecognizer(longTap)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let supplView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! PhototHeaderRV
       
        supplView.titleLabel.text = categories[indexPath.section].name
        return supplView
    }
    
    
    
    
}

extension ViewController: UICollectionViewDelegate{
    
    

    
    
    
    
}



extension ViewController: UICollectionViewDelegateFlowLayout{
    
}
