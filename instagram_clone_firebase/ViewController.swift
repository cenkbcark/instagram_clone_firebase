//
//  ViewController.swift
//  instagram_clone_firebase
//
//  Created by Cenk Bahadır Çark on 18.08.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInButtonClicked(_ sender: Any) {
        
        if emailTextField.text != nil && passwordTextField.text != nil{
            
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authdata, error in
                if error != nil{
                    self.makeAlert(errorInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    self.dismiss(animated: true)
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
                
            }
            
        }else{
            makeAlert(errorInput: "Error", messageInput: "Please enter your e-mail and password!")
        }
        
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toRegister", sender: nil)
        
    }
    
    func makeAlert (errorInput: String, messageInput : String) {
        let alert = UIAlertController(title: errorInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
}

