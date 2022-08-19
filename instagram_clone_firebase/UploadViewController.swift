//
//  UploadViewController.swift
//  instagram_clone_firebase
//
//  Created by Cenk Bahadır Çark on 18.08.2022.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var commentText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        uploadImageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func selectImage() {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType =   .photoLibrary
        present(pickerController, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
        
    }
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        //References
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let photoFolder = storageReference.child("Photos")
        
        if let data = uploadImageView.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString
            
            let imageReference = photoFolder.child("\(uuid).jpeg")
            imageReference.putData(data, metadata: nil) { metadata, error in
                
                if error != nil {
                    self.makeAlert(errorInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    imageReference.downloadURL { url, error in
                        
                        if error == nil{
                            let imageURL = url?.absoluteString
                            //Database
                            let fireStoreDatabase = Firestore.firestore()
                            
                            var fireStoreReference : DocumentReference?
                            
                            let fireStoreDictionary = ["ImageUrl": imageURL!,"postedBy" : Auth.auth().currentUser!.email,"postComment" : self.commentText.text!,"date" : FieldValue.serverTimestamp(),"likes" : 0] as [String : Any]
                            
                            fireStoreReference = fireStoreDatabase.collection("Posts").addDocument(data: fireStoreDictionary, completion: { error in
                                if error != nil {
                                    self.makeAlert(errorInput: "Error", messageInput: error!.localizedDescription)
                                }else{
                                    self.uploadImageView.image = .init(systemName: "photo.fill")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                        }
                    }
                }
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
