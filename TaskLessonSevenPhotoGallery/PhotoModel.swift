//
//  PhotoModel.swift
//  TaskLessonSevenPhotoGallery
//
//  Created by Andrey Petrovskiy on 3/26/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation
import UIKit

class Cat{
    var name: String
    var data: [PhotoModel] = []
    init(name: String) {
        self.name = name
    }
}

class PhotoModel{
    
    
    var name: String
    var date =  Date()
    var device: String
    var photo: String
    
    
    init(name: String, date: Date, device: String, photo: String){
        self.name = name
        self.date = date
        self.device = device
        self.photo = photo
        
    }
    
}
