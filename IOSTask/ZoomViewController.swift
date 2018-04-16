//
//  ZoomViewController.swift
//  IOSTask
//
//  Created by Aditya Bonthu on 15/04/18.
//  Copyright © 2018 Aditya Bonthu. All rights reserved.
//

import UIKit

class ZoomViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var scrollView: UIScrollView?
    @IBOutlet var imageView: UIImageView?
    
    var selectedShowImage = String()
    var doubleTap : UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String // getting directory
        let path = documentDirectory + "/" + selectedShowImage      // attaching directory with image name
        imageView?.image = UIImage(contentsOfFile: path)
        
        // Setting the Maxmium and minimum values for zoom
        scrollView?.minimumZoomScale = 1.0
        scrollView?.maximumZoomScale = 5.0
        
        // Double tap to zoom image
        doubleTap = UITapGestureRecognizer (target: self, action: #selector(doubletapImageView))
        doubleTap?.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UIScrollView Delegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    // double tap on image to zoom action
    @objc func doubletapImageView() {
        if (scrollView?.zoomScale)! > (scrollView?.minimumZoomScale)! {
            scrollView?.setZoomScale((scrollView?.minimumZoomScale)!, animated: true)
        }
        else {
            scrollView?.setZoomScale((scrollView?.maximumZoomScale)!, animated: true)
        }
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
