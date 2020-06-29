//
//  Styles.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit
import Foundation

class Styles {
    
    static func updateUnderLineWidth()->CGFloat {
        var updatedWidth:CGFloat = 0
        if UIDevice.current.orientation.isLandscape {
            updatedWidth = UIScreen.main.bounds.height - (UIScreen.main.bounds.height/6)
        } else {
            updatedWidth = UIScreen.main.bounds.width - (UIScreen.main.bounds.width/6)
        }
        return updatedWidth
    }
    
    static func styleTextField(textField:UITextField) {
        let width = updateUnderLineWidth()
        let bottomLine=CALayer()
        bottomLine.frame=CGRect(x: 0, y: textField.frame.height, width: width , height: 0.75)
        bottomLine.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 1).cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
    }
    
    static func styleFilledButton(button:UIButton) { 
        button.backgroundColor=UIColor.init(displayP3Red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        
        button.layer.cornerRadius=25
        button.tintColor = .white
    }
    
}

