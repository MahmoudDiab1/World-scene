//
//  InterestsVC.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit
import Firebase
class InterestsVC: UIViewController {
    
        @IBOutlet weak var interestesTableView: UITableView!
        @IBOutlet weak var addInterestBtn: UIButton!
        @IBOutlet weak var userInterestTxtField: UITextField!
        
        var interestData=[String]()
        override func viewDidLoad() {
            super.viewDidLoad()
            interestesTableView.dataSource = self
            interestesTableView.delegate = self
            guard let currentUid = Firebase.Auth.auth().currentUser?.uid else { return }
            let ref = Database.database().reference().child("users").child(currentUid)
            ref.child("InterestsKeywords").observe(.value) { (snapshot) in
                guard let data = snapshot.value as? [String:Any] else { return }
                self.interestData = data.map{$0.key}
                self.interestesTableView.reloadData()
            }
        }
        
        
        @IBAction func addInterestPressed(_ sender: Any) {
            guard let currentUid = Firebase.Auth.auth().currentUser?.uid else { return }
            let interest = [userInterestTxtField.text:"1"]
            let ref = Database.database().reference().child("users").child(currentUid)
            ref.child("InterestsKeywords").updateChildValues(interest)
            ref.child("InterestsKeywords").observe(.value) { (snapshot) in
                guard let data = snapshot.value as? [String:Any] else { return }
                self.interestData = data.map{$0.key}
                self.interestesTableView.reloadData()
            }
            
        }
        
        
    }
    extension  InterestsVC:UITableViewDataSource, UITableViewDelegate
    {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            interestData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "interestsCell", for: indexPath)
            cell.textLabel?.text = interestData[indexPath.row]
            return cell
            
        }
        
        
    }
