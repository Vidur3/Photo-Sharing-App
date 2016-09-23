//
//  PostImgVC.swift
//  ParseStarterProject-Swift
//
//  Created by Vidur Singh on 06/09/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse


class PostImgVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageToPost: UIImageView!
    
    
    
    @IBOutlet weak var captionTxt: UITextField!
    
    var hasSelectdImg = false
    
    let imgPicker = UIImagePickerController()
    
    var activityView = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pickImage(sender: AnyObject) {
        
        imgPicker.delegate = self
        imgPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imgPicker.allowsEditing = false
        
        self.presentViewController(imgPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        imageToPost.image = image
        hasSelectdImg = true
    }

    @IBAction func postImg(sender: AnyObject) {
        
        if hasSelectdImg {
        
        activityView = UIActivityIndicatorView(frame: self.view.frame)
        activityView.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        activityView.center = self.view.center
        
        activityView.hidesWhenStopped = true
        activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
        self.view.addSubview(activityView)
        activityView.startAnimating()
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        
        let post = PFObject(className: "Posts")
        
        post["caption"] = captionTxt.text
        
        post["userId"] = PFUser.currentUser()?.objectId
        
        let imgData = UIImagePNGRepresentation(imageToPost.image!)
        
        let imageFile = PFFile(name: "image.png", data: imgData!)
        
        post["imagefile"] = imageFile
        
        post.saveInBackgroundWithBlock { (success, error) in
            
            self.activityView.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()

            
            if error == nil {
                
                print("Image Posted on the server")
                
                self.imageToPost.image = UIImage(named: "images4.png")
                self.captionTxt.text = ""
                
            }
            
        }
        } else {
            
           
            print("Pick an Image First")
        }
        
}
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
