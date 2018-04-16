//
//  ViewController.swift
//  IOSTask
//
//  Created by Aditya Bonthu on 14/04/18.
//  Copyright © 2018 Aditya Bonthu. All rights reserved.
//

import UIKit

class AddImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    // IBOutlets
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var textView: UITextView?
    
    let imageManager = ImageDataManager()
    
    // Delcaring Varibles
    var imagePicker = UIImagePickerController()
    var number = Int() // to change the name of the image when saving into documents
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self             // Setting Delegate
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Action for Button to add images
    @IBAction func addImageButtonPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary                      // Setting the Source Type to PhotoLibrary
        self.present(imagePicker, animated: true, completion: nil)  // Presenting the PhotoLibaray Screen
    }
    
    // Action to submit the image that the user has added
    @IBAction func submitImageButtonAction(_ sender: UIButton) {
        // get the documents directory url
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "\(Date.timeIntervalSinceReferenceDate).jpg"  // choose a name for your image with timestamp
        // making sure that if description is empty to save
        if let textMatter = textView?.text {
            let image = Image(image: fileName, text: textMatter)  
            ImageDataManager.saveContent(with: image)       // saving imagefile name with description 
        }
        
        // create the destination file url to save your image
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        // get your UIImage jpeg data representation and check if the destination file url already exists
        if let data = UIImageJPEGRepresentation((imageView?.image)!, 1.0),
            !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                // writes the image data to disk
                try data.write(to: fileURL)
                print("file saved \(fileURL)")
            } catch {
                print("error saving file:", error)
            }
        }
    }
    
    // ImagePicker Delegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView?.image = pickedImage     // get the image selected By User and show on ImageView
        }
        self.dismiss(animated: true, completion: nil) // dismiss the UIImagePicker Screen
    }
    
    // dismiss the picker when user clicks on cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // dismiss keyboard when clicked on keyboard done button
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView?.resignFirstResponder()        // to dismiss keyboard when user touches the screen.
    }
    
}

