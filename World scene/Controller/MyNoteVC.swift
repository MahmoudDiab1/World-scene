//
//  MyNoteVC.swift
//  World scene
//
//  Created by mahmoud diab on 6/29/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit

class MyNoteVC: UIViewController {
    @IBOutlet weak var noteTextView: UITextView!
    var note : String?
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        noteTextView.text = note
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
 

}
