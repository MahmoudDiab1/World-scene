//
//  LanguageVC.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit

class LanguageVC: UIViewController { 
    //MARK: outlets
    @IBOutlet weak var languagesTableView: UITableView!
    var languagesCode = [ "ar","de","en","fr","he","it",
                          "nl","no","pt","ru","se","zh" ]
    
    //    MARK: variables
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLanguageTable()
    }
    func configureLanguageTable() {
        languagesTableView.dataSource = self
        languagesTableView.delegate = self
        languagesTableView.register(UINib(nibName: "LanguagesTableViewCell", bundle: nil), forCellReuseIdentifier: "LanguagesTableViewCell")
    }
    
    
}
//MARK: extensions

extension LanguageVC:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languagesCode.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LanguagesTableViewCell", for: indexPath) as?  LanguagesTableViewCell else { return LanguagesTableViewCell() }
        let languageCode = languagesCode[indexPath.row]
        cell.configureLanguageCell(language: languageCode)
        return cell
        
    }
    
    
    
}
