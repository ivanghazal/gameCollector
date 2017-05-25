//
//  GameViewController.swift
//  GameColector
//
//  Created by Ivan Ghazal on 5/21/17.
//  Copyright © 2017 Ivan Ghazal. All rights reserved.
//

import UIKit


class GameViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UITextViewDelegate {

    @IBOutlet weak var addUpdateButton: UIButton!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var descriptionTextView: UITextView!
  
    @IBOutlet weak var okPopupButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    var game : Game? = nil
    
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
        
        // for declare the description text view
        descriptionTextView.delegate = self
        
        okPopupButton.isHidden = true
        
    }

    @IBAction func okPopupButtonDidTouch(_ sender: Any) {
        print ("ok")
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
    
    // build place hint for uitextview 
    
    func textViewDidBeginEditing(_ textView: UITextView) {
       
        if  game?.descriptionFull == nil {
            descriptionTextView.text = ""
        }
        
     
        print(descriptionTextView.layer.zPosition)
        descriptionTextView.frame = CGRect(x: 0, y: 80, width: self.view.frame.width , height: self.view.frame.height - 80)
        descriptionTextView.layer.zPosition = 100;
        okPopupButton.isHidden = false
        okPopupButton.layer.zPosition = 101
 
    }
    

    
}
