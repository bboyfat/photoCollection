//
//  ViewController.swift
//  TaskLessonSevenPhotoGallery
//
//  Created by Andrey Petrovskiy on 3/26/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet var collectionView: UICollectionView!
    
    
    var animal: [PhotoModel] = [PhotoModel(name: "Tulp", date: Date(), device: "X", photo:  "2"), PhotoModel(name: "Tulp", date: Date(), device: "XSMax", photo:  "2"), PhotoModel(name: "Tulp", date: Date(), device: "XS", photo:  "2"), PhotoModel(name: "Tulp", date: Date(), device: "XR", photo:  "2")]
    var flowers: [PhotoModel] = [ PhotoModel(name: "Tulp", date: Date(), device: "XSMax", photo:  "0"), PhotoModel(name: "Tulp", date: Date(), device: "XS", photo:  "0"), PhotoModel(name: "Tulp", date: Date(), device: "XR", photo:  "0")]
     var nature: [PhotoModel] = [PhotoModel(name: "Tulp", date: Date(), device: "X", photo:  "1"), PhotoModel(name: "Tulp", date: Date(), device: "XSMax", photo:  "1"), PhotoModel(name: "Tulp", date: Date(), device: "XS", photo:  "1"), PhotoModel(name: "Tulp", date: Date(), device: "XR", photo:  "1")]
     var electronic: [PhotoModel] = [ PhotoModel(name: "Tulp", date: Date(), device: "XS", photo:  "3"), PhotoModel(name: "Tulp", date: Date(), device: "XR", photo:  "3")]
    //var cathegory = Cathegory()
    var model: [Cat] = [Cat(name: "Animal"), Cat(name: "Nature"), Cat(name: "Flowers"), Cat(name: "Electronic")]
    
    
    var cathegories:[Cathegory] = [.animal,.nature,.flowers,.electronic]
    override func viewDidLoad() {
        super.viewDidLoad()
        model[0].data = animal
        model[1].data = flowers
        model[2].data = nature
        model[3].data = electronic


    }

    @objc func showAction(sender: UILongPressGestureRecognizer){
        let cont = UIAlertController(title: "Photo", message: nil, preferredStyle: .actionSheet)
        let act = UIAlertAction(title: "Delete", style: .destructive, handler: nil)
        let edit = UIAlertAction(title: "Edit", style: .default) { (action) in
            
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
            
            print("\(sender.view?.index(ofAccessibilityElement: self))")
            let index = sender.view?.index(ofAccessibilityElement: self)
//            let indexPath = self.collectionView.indexPathForItem(at: sender.location(in: self.collectionView)) ?? IndexPath()
            vc.photoModel = self.model[index!].data[index!]
//
            let indexPath = IndexPath()
            if sender == self.collectionView.cellForItem(at: indexPath){
                vc.photoModel = self.model[indexPath.section].data[indexPath.row]
            }
            
            let navController = UINavigationController(rootViewController: vc)
            self.present(navController, animated: true, completion: nil)
//            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        cont.addAction(edit)
        cont.addAction(act)
        print("gesture!")
        present(cont, animated: true, completion: nil)
    }

}


extension ViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return model.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
       return model[section].data.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoViewCell
        
        cell.photoIV.image = UIImage(named: "\(model[indexPath.section].data[indexPath.item].photo)")
//        print("\(model[indexPath.section].data[indexPath.item].photo)")
        
//        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(showAction))
//        cell.addGestureRecognizer(longTap)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let supplView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! PhototHeaderRV
       
        supplView.titleLabel.text = model[indexPath.section].name
        return supplView
    }
    
    
    
    
}

extension ViewController: UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(showAction))
        collectionView.cellForItem(at: indexPath)?.addGestureRecognizer(longTap)

//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
//
//        vc.photoModel = model[indexPath.section].data[indexPath.item]
//
//        navigationController?.pushViewController(vc, animated: true)

    }

//    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
//
//
//    }
//    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        return true
//    }
    
    
    
    
}



extension ViewController: UICollectionViewDelegateFlowLayout{
    
}
