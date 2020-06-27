//
//  SourcesTableViewCell.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit
import Firebase
class SourcesTableViewCell: UITableViewCell {
    
    //MARK:-outlets-
    //    @IBOutlet weak var countryLbl: UILabel!
    //    @IBOutlet weak var languageLble: UILabel!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var sourceDescription: UILabel!
    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var cellBackgroundView: UIView!
    
    //    MARK:- Variables-
    var sourceNameLiked:String?
    var favouriteSources:[String]?
    var sourceID:String?
    
    //    MARK:- lifecycle-
    override func awakeFromNib() {
        super.awakeFromNib()
        followButton.setImage(UIImage(named:"heartOE.png"), for: .normal)
        cellBackgroundView.layer.cornerRadius = .pi
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    //    MARK:- update  user favourits and save it as user preferences
    //    MARK:- Use preferences to update user feed.
    func configureCell(with source:Source) {
        categoryName.text = source.category.uppercased()
        sourceName.text = source.name
        sourceDescription.text = source.sourceDescription
        sourceID = source.id
    }
    
    @IBAction func followBtnClicked(_ sender: Any) {
        guard let userUid = Firebase.Auth.auth().currentUser?.uid else { return }
        let source = [sourceID:"1"]
        let ref = Database.database().reference().child("users").child("\(userUid)")
        if followButton.tag==0 {
            // case followed after click
            followButton.setImage(UIImage(named:"heartFB.png"), for: .normal)
            if let sourceNameLiked=sourceNameLiked {
                favouriteSources?.append(sourceNameLiked)
            }
            followButton.tag=1
            ref.child("favouriteSources").updateChildValues(source)
        } else {
            //  case unfollowed after click
            followButton.setImage(UIImage(named:"heartOE.png"), for: .normal)
            followButton.tag=0
            ref.child("favouriteSources").updateChildValues([sourceID:"0"])
        }
    } 
}
