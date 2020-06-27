//
//  LanguagesTableViewCell.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit
import Firebase
class LanguagesTableViewCell: UITableViewCell {
 
        //MARK: outlet
        @IBOutlet weak var checkButton: UIButton!
        @IBOutlet weak var languageLable: UILabel!
        @IBOutlet weak var cellBackgroundView: UIView!
        //    MARK: variable
        var languagesDic = ["ar":"Arabic","de":"German","en":"English","fr":"French","he":"Hebrew","it":"Italian","nl":"Niederländisch","no":"Norwegisch","pt":"Portuguese","ru":"Russian","se":"Northern Sami","zh":"Chinese"]
        
        override func awakeFromNib() {
            super.awakeFromNib()
            checkButton.setImage(UIImage(named:"heartOE.png"), for: .normal)
            
            cellBackgroundView.layer.cornerRadius = .pi
        }
        
        
        @IBAction func languageChoosed(_ sender: Any)
        {
            
            guard  let currentUid = Firebase.Auth.auth().currentUser?.uid else { return }
            let language = [ languageLable.text:"1"]
            let ref = Database.database().reference().child("users").child(currentUid)
            
            if checkButton.tag == 0
            {
                checkButton.setImage(UIImage(named:"heartFB.png"), for: .normal)
                ref.child("preferedLanguages").updateChildValues( language)
                checkButton.tag = 1
            }
            else
            {
                checkButton.setImage(UIImage(named:"heartOE.png"), for: .normal)
                ref.child("preferedLanguages").updateChildValues( [languageLable.text:"0"])
                checkButton.tag = 0
            }
        }
        func configureLanguageCell(language : String)
        {
            languageLable.text = languagesDic[language]
        }
        
    }
