//
//  GameViewController.swift
//  GameColector
//
//  Created by Ivan Ghazal on 5/21/17.
//  Copyright © 2017 Ivan Ghazal. All rights reserved.
//

import UIKit

class GameViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate  {
    
    @IBOutlet weak var addUpdateButton: UIButton!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var descriptionTextView: SpringTextView!
    
    @IBOutlet weak var okPopupButton: SpringButton!
    
    var imagePicker = UIImagePickerController()
    
    var game : Game? = nil
    
    var oldFrameDTV = CGRect()
    var newFrameDTV = CGRect()
    
    var navHeight : CGFloat = 0
    
    //declare for deafult textview color ,font ,background
    var backgroundColor_descriptionTextView :UIColor = UIColor.white
    var textContainerInset_descriptionTextView :UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        deleteButton.isHidden = true
        
        
        if game != nil {
            
            mainImageView.image = UIImage(data : game!.image! as Data )
            titleTextField.text = game!.title
            descriptionTextView.text = game!.descriptionFull
            
            
            addUpdateButton.setTitle("Update", for: .normal)
            deleteButton.isHidden = false
        }
        
        
        okPopupButton.isHidden = true
        okPopupButton.layer.zPosition = 101
        
        navHeight = 60
        //(self.navigationController!.view.frame.size.height)
        print(navHeight)
        
        // have the old size of popup
        oldFrameDTV = descriptionTextView.frame
        newFrameDTV = CGRect(x: 0, y: navHeight, width: self.view.frame.width , height: self.view.frame.height - navHeight)
        
        
        
        
        
        //set deafult textview color ,font ,background
        backgroundColor_descriptionTextView =  descriptionTextView.backgroundColor!
        textContainerInset_descriptionTextView = descriptionTextView.textContainerInset
        
        
        
        
        
    }
    
    
    @IBAction func addButtonDidTouch(_ sender: Any) {
        
        
        if game != nil {
            
            game!.title = titleTextField.text
            game!.image = UIImagePNGRepresentation(mainImageView.image!)! as NSData
            game!.descriptionFull = descriptionTextView.text
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            navigationController!.popViewController(animated: true)
            
            
            
        }else{
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let game = Game(context: context)
            game.title = titleTextField.text
            game.image = UIImagePNGRepresentation(mainImageView.image!)! as NSData
            game.descriptionFull = descriptionTextView.text
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            navigationController!.popViewController(animated: true)
            
        }
        
        
    }
    
    
    @IBAction func photoButtonDidTouch(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        mainImageView .image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cameraButtonDidTouch(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func deleteButtonDidTouch(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(game!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
    }
    
    
    // ok Button ---------------
    
    @IBAction func okPopupButtonDidTouch(_ sender: Any) {
        


        
        
        // animation
        okPopupButton.animation = "zoomOut"
        okPopupButton.duration = 0.45
        okPopupButton.animateTo()
        
       // descriptionTextView.delay = 0.45


        
        descriptionTextView.animation = "zoomOutIn"
        descriptionTextView.duration = 0.25
        descriptionTextView.animateToNext {
            self.descriptionTextView.layer.zPosition = 0;
            self.descriptionTextView.frame = self.oldFrameDTV
            self.descriptionTextView.backgroundColor = self.backgroundColor_descriptionTextView
            self.descriptionTextView.textColor = UIColor.black
            self.descriptionTextView.textContainerInset = self.textContainerInset_descriptionTextView
            self.descriptionTextView.font = UIFont.boldSystemFont(ofSize: 14)
            self.okPopupButton.isHidden = true
        }

        
        
    }
    
    @IBAction func exlargeButtonDidTouch(_ sender: Any) {
        
        if  game?.descriptionFull == nil {
            descriptionTextView.text = ""
        }
        
        // popup edit layer
        
        descriptionTextView.frame = newFrameDTV
        descriptionTextView.layer.zPosition = 100;
        okPopupButton.isHidden = false
        
        descriptionTextView.backgroundColor = UIColor.black
        descriptionTextView.textColor = UIColor.white
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 28, left: 28, bottom: 8, right: 18)
        descriptionTextView.font = UIFont.boldSystemFont(ofSize: 28)
        
        
        
        
        
        // animation
        descriptionTextView.animation = "slideUp"
        descriptionTextView.duration = 0.45
        descriptionTextView.animate()
        
        okPopupButton.animation = "zoomIn"
        okPopupButton.duration = 0.45
        okPopupButton.delay = 0.3
        okPopupButton.animate()
        
    }
    

    
}

