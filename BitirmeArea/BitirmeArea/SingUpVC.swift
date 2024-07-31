import UIKit
import Parse

class SingUpVC: UIViewController {

    
    @IBOutlet weak var userNameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
     
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Şifre alanının özelliklerini belirle
                configurePasswordTextField()
        
      //  userManager.createAdminUser() // Uygulama başladığında admin kullanıcısını oluşt
        
    }
    func configurePasswordTextField() {
        // Şifre girişini gizle
        passwordText.isSecureTextEntry = true
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        
        if userNameText.text != "" && passwordText.text != ""{
            
            PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { (user,  error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                    
                } else{
                    //segue
                    self.performSegue(withIdentifier: "toPlacesVc", sender: nil)

                    
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
                    self.performSegue(withIdentifier: "toPlacesVc", sender: nil)
                        
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


// Kullanıcının admin olup olmadığını kontrol eder ve ona göre yönlendirir
/*func checkIfAdmin(user: PFUser) {
    let roleQuery = PFRole.query()
    roleQuery?.whereKey("name", equalTo: "Admin")
    roleQuery?.whereKey("users", equalTo: user)
    roleQuery?.getFirstObjectInBackground { (role, error) in
        if role != nil {
            // Kullanıcı admin, admin paneline yönlendir
            self.performSegue(withIdentifier: "toAdminPanel", sender: nil)
        } else {
            // Kullanıcı normal kullanıcı, normal kullanıcı ekranına yönlendir
            self.performSegue(withIdentifier: "toPlacesVc", sender: nil)
        }
    }
}*/
}
