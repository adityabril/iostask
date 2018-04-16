//
//  Image.swift
//  IOSTask
//
//  Created by Aditya Bonthu on 15/04/18.
//  Copyright © 2018 Aditya Bonthu. All rights reserved.
//

import Foundation

class Image: Codable {
    // Delcaring Properties
    var image: String
    var textMatter: String?
    
    // initialization
    init(image: String, text: String) {
        self.image = image
        self.textMatter = text
    }
}

// Model Class
class ViewModel {
    
    private var ImageSaved = [Image]()
    // getting the number of saved images in json file
    func numberOfImagesSaved() -> Int {
        ImageSaved.removeAll()
        ImageSaved.append(contentsOf:ImageDataManager.getAllImage())
        return ImageSaved.count
    }
    // to show then
    func ImagesSaved(at indexPath:IndexPath) -> Image {
        return ImageSaved[indexPath.item]
    }
}
