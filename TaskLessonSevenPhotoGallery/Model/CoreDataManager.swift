//
//  CoreDataManager.swift
//  TaskLessonSevenPhotoGallery
//
//  Created by Andrey Petrovskiy on 3/30/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation
import CoreData


class CoreDataManager{
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let conteiner = NSPersistentContainer(name: "TaskLessonSevenPhotoGallery")
        conteiner.loadPersistentStores(completionHandler: { (storeDescriprion, error) in
            if let error = error{
                fatalError("Loading of store failed \(error)")
            }
        })
        return conteiner
    }()
    
    
    
}
