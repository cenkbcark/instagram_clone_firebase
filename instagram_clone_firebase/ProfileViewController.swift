//
//  ProfileViewController.swift
//  instagram_clone_firebase
//
//  Created by Cenk Bahadır Çark on 18.08.2022.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
            self.dismiss(animated: true)
            self.performSegue(withIdentifier: "logout", sender: nil)
            
        }catch{
            print(error.localizedDescription)
        }
    }
}
