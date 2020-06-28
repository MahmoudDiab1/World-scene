//
//  ExploreCollectionViewCell.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit

class ExploreCollectionViewCell: UICollectionViewCell {
    
    //    MARK:- Outlets 
    //        @IBOutlet weak var imageEffectView: UIView!
    @IBOutlet weak var categoryName: UILabel!
    //    MARK:- Variable
    var articlesCategorized = [article?]()
    
    
    //    MARK:- Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    //    MARK::- Functions
    func  configureItem(with category : String   ){
        categoryName.text = category.uppercased() 
    }
    
}
