//
//  ViewController.swift
//  BitirmeArea
//
//  Created by Sema UĞUR on 16.04.2024.
//

import UIKit
import Parse

class SingUpVC: UIViewController {

    
    @IBOutlet weak var userNameText: UITextField!
    
    
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        
      
        
        
    }

    @IBAction func signInClicked(_ sender: Any) {
        
        if userNameText.text != "" && passwordText.text != ""{
            
            PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { (user,  error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                    
                } else{
                    //segue
                    self.performSegue(withIdentifier: "toSpaceVc", sender: nil)
                    
               //     print("Welcome")
               //     print(user?.username)
                    
                }
            }
        }                else {
            makeAlert(titleInput: "Error", messageInput: "Username / Password ?")
            
        }

        
        
    }
    

    @IBAction func signUpClicked(_ sender: Any) {
        
        if userNameText.text != "" && passwordText.text != ""{
            
            let user = PFUser()
            user.username = userNameText.text!
            user.password = passwordText.text!
            
            
            user.signUpInBackground { (succes, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error!!")
                }else {
                    self.performSegue(withIdentifier: "toSpaceVc", sender: nil)
                        
                    }
                }
            }
                
                else {
            makeAlert(titleInput: "Error", messageInput: "Username / Password ?")
            
        }
                    
    }
    
    func makeAlert(titleInput: String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
}

