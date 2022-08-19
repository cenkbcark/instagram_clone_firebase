//
//  RegisterViewController.swift
//  instagram_clone_firebase
//
//  Created by Cenk Bahadır Çark on 18.08.2022.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var repasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func registerButtonClicked(_ sender: Any) {
        
        if emailTextField.text != nil{
            if passwordTextField.text == repasswordTextField.text{
                Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { data, error in
                    if error != nil{
                        self.makeAlert(errorInput: "Error", messageInput: "Ups..! Something went wrong!")
                    }else{
                        let alert = UIAlertController(title: "Succes!", message: "You have successfully create an account!", preferredStyle: UIAlertController.Style.alert)
                        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
                            self.dismiss(animated: true)
                            self.performSegue(withIdentifier: "backToHome", sender: nil)
                        }
                        alert.addAction(okButton)
                        self.present(alert, animated: true)
                    }
                }
            }else{
                makeAlert(errorInput: "Error", messageInput: "Password does not match!")
            }
        }
    }
    func makeAlert (errorInput: String, messageInput : String) {
        let alert = UIAlertController(title: errorInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    
    
}
