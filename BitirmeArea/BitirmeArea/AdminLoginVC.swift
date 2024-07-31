
/*
import UIKit
import Parse

class AdminLoginVC: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ek kodlar ve işlemler buraya eklenebilir
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            showAlert(withTitle: "Error", message: "Please enter username and password.")
            return
        }
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if let error = error {
                self.showAlert(withTitle: "Error", message: error.localizedDescription)
            } else if let user = user {
                self.performSegue(withIdentifier: "toAdminPanel", sender: nil)
            } else {
                self.showAlert(withTitle: "Error", message: "An unknown error occurred.")
            }
        }
    }
    
    private func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
*/
