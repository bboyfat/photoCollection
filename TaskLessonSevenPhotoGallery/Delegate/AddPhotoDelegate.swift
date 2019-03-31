//
//  AddPhotoDelegate.swift
//  TaskLessonSevenPhotoGallery
//
//  Created by Andrey Petrovskiy on 3/28/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation


protocol AddPhotoDelegate{
    func didAddPhoto( model: Photo)
    func didEdtiPhoto(model: Photo)
}
