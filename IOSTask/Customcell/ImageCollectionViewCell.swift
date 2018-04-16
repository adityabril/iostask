//
//  ImageCollectionViewCell.swift
//  IOSTask
//
//  Created by Aditya Bonthu on 15/04/18.
//  Copyright © 2018 Aditya Bonthu. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var textLabel: UILabel?
    // dequeue method for collection cell
    internal static func dequeue(fromCollectionView collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> ImageCollectionViewCell {
        guard let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath) else {
            fatalError("*** Failed to dequeue CollectionCell ***")
        }
        return cell
    }
    
    func bindData(image: Image) {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String // getting directory
        let path = documentDirectory + "/" + image.image // attaching directory with image name
        imageView?.image = UIImage(contentsOfFile: path) // showing image in imageview
        textLabel?.text = image.textMatter  // showing text in label
    }
    
}
