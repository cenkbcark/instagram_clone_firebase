//
//  HomeViewController.swift
//  instagram_clone_firebase
//
//  Created by Cenk Bahadır Çark on 18.08.2022.
//

import UIKit
import Firebase
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeCountArray = [Int]()
    var userImageArray = [String]()
    var documentIDArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 10.0
        getDataFromFireStore()
       
    }
    func getDataFromFireStore(){
        
        let fireStoreDatabase = Firestore.firestore()
        let settings = fireStoreDatabase.settings
        fireStoreDatabase.settings = settings
        
        fireStoreDatabase.collection("Posts").order(by: "date", descending: true)
            .addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                
                if snapshot?.isEmpty != true {
                    //need prevent duplicate data
                    self.userImageArray.removeAll()
                    self.likeCountArray.removeAll()
                    self.userCommentArray.removeAll()
                    self.userEmailArray.removeAll()
                    self.documentIDArray.removeAll()
                    
                    for document in snapshot!.documents {
                        
                        let documentID = document.documentID
                        self.documentIDArray.append(documentID)
                        
                        
                        if let postedBy = document.get("postedBy") as? String{
                            self.userEmailArray.append(postedBy)
                        }
                        if let postComment = document.get("postComment") as? String{
                            self.userCommentArray.append(postComment)
                        }
                        if let likes = document.get("likes") as? Int{
                            self.likeCountArray.append(likes)
                        }
                        if let userImageArray = document.get("ImageUrl") as? String{
                            self.userImageArray.append(userImageArray)
                        }
    
                    }
                    self.tableView.reloadData()
                }
                
                
                
            }
        }
        
        
    }

    
    
    
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeCell
        cell.layer.cornerRadius = 25.0
        cell.userNameLabel.text = userEmailArray[indexPath.row]
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.likeCountLabel.text = "\(likeCountArray[indexPath.row])"
        cell.userImageView.sd_setImage(with: URL(string: userImageArray[indexPath.row]))
        cell.documentIDLabel.text = documentIDArray[indexPath.row] //visible
        return cell
    }
}
