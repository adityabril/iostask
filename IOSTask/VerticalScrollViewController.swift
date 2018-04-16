//
//  VerticalScrollViewController.swift
//  IOSTask
//
//  Created by Aditya Bonthu on 14/04/18.
//  Copyright © 2018 Aditya Bonthu. All rights reserved.
//

import UIKit

class VerticalScrollViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView?
    
    let viewModel = ViewModel()
    var selectedImage = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         // configuration of collection view
        if let collection = collectionView {
            configure(collectionView: collection)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImageSegue" {
            let zoomVC = segue.destination as? ZoomViewController     // passing the image
            zoomVC?.selectedShowImage = selectedImage
        }
    }


}

extension VerticalScrollViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    internal func configure(collectionView: UICollectionView) {
        collectionView.registerReusableCell(ImageCollectionViewCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfImagesSaved()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ImageCollectionViewCell.dequeue(fromCollectionView: collectionView, atIndexPath: indexPath)
        cell.bindData(image: viewModel.ImagesSaved(at: indexPath))          // calling function
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = viewModel.ImagesSaved(at: indexPath)
        selectedImage = image.image             // getting the image to pass to zoomVC
        print(selectedImage)
        self.performSegue(withIdentifier: "showImageSegue", sender: self)           // perform segue
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: self.view.frame.width, height: self.view.frame.height / 1.5)
    }
    
}
