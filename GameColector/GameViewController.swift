//
//  GameViewController.swift
//  GameColector
//
//  Created by Ivan Ghazal on 5/21/17.
//  Copyright © 2017 Ivan Ghazal. All rights reserved.
//

import UIKit


class GameViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
    }


    @IBAction func addButtonDidTouch(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let game = Game(context: context)
        game.title = titleTextField.text
        game.image = UIImagePNGRepresentation(mainImageView.image!)! as NSData
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
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
    
    }
    
    
}
