//
//  Bookmarks.swift
//  Seen
//
//  Created by mahmoud diab on 5/28/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit
import Firebase

class Bookmarks: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         
    }
  
//    func getSavedArticles (numberOfArticles:Int)
//    {
//        guard let user = Firebase.Auth.auth().currentUser else { return }
//        let uid = user.uid
//        let savedArticleRef=Database.database().reference().child("users").child(uid).child("savedArticles")
//        
//        savedArticleRef.observe(.value){ snapshot in
//            var i = 1
//            var dic=[String:Any]()
//            while i < numberOfArticles
//           {
//            dic = (snapshot.childSnapshot(forPath: "\(i)").value as? [String:Any])!
//            i += 1
//            }
//            print(dic)
//        }
//    }
}
