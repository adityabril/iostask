//
//  ImageDataManager.swift
//  IOSTask
//
//  Created by Aditya Bonthu on 16/04/18.
//  Copyright © 2018 Aditya Bonthu. All rights reserved.
//

import UIKit

class ImageDataManager {
    // creating a file
    private class var cachePath:String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let path = documentDirectory + "/images.json" // giving file name
        print(path)
        return path
    }
    
    private class var cacheURL : URL {
        return URL(fileURLWithPath: cachePath)
    }
    // setter method to save the image and text to json file
    static func saveContent(with imageName:Image) {
        var names = getAllImage()
        names.append(imageName)
        let jsonEncoder = JSONEncoder()
        do {
            let encodedData = try jsonEncoder.encode(names)  
            do {
                try encodedData.write(to: cacheURL)
            }
            catch {
                print("Failed to encode data: \(error.localizedDescription)")
            }
            
        } catch {
            print("Failed to write JSON data: \(error.localizedDescription)")
        }
    }
    // getter method to get the saved images with description in array of images
    class func getAllImage() -> [Image] {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf:cacheURL)
            do {
                let images = try jsonDecoder.decode([Image].self, from: data)
                return images
            } catch {
                print("Unable to Decode")
            }
        } catch {
            print("Unable to read the data")
        }
        return [Image]()
    }
}
