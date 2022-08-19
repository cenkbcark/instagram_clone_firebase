//
//  HomeCell.swift
//  instagram_clone_firebase
//
//  Created by Cenk Bahadır Çark on 18.08.2022.
//

import UIKit
import Firebase
class HomeCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!

    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var documentIDLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var didLiked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    @IBAction func likeButtonClicked(_ sender: Any) {
        
        print("clicked")
            
            let fireStoreDatabase = Firestore.firestore()
            
            if let likeCount = Int(likeCountLabel.text!) {
                
                let likeStorage = ["likes" : likeCount + 1 ] as [String : Any]
                
                fireStoreDatabase.collection("Posts").document(documentIDLabel.text!).setData(likeStorage, merge: true)
            }
        }
}
