//
//  ForYouVC.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit
   import Firebase
class ForYouVC: UIViewController {
    
        //MARK:- Outlets
        @IBOutlet weak var forYouTable: UITableView!
        //    MARK:- Variables
        var articlesForYou = [article?]()
        var sourcesRecieved = [String]()
        var keywordsRecieved = [String]()
        var languagesRecieved = [String]()
        var selectedIndex:IndexPath?
        //    MARK:- LifeCycle
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
         
            getPreferedArticles()
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            configureExploreTable()
            
        }
        
        
        
            // MARK:- Actions
        
        
        
            @IBAction func setPreferences(_ sender: UIButton) {
                switch sender.tag
                {
//                case 0:
//                    
//                    let vc = storyboard?.instantiateViewController(withIdentifier: "SourceVC") as! SourceVC
//                    navigationController?.pushViewController(vc, animated: true)
                case 1:
                    let vc = storyboard?.instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
                    navigationController?.pushViewController(vc, animated: true)
                case 2 :
                    let vc = storyboard?.instantiateViewController(withIdentifier: "InterestsVC") as! InterestsVC
                    navigationController?.pushViewController(vc, animated: true)
                    
                default:
                    print("handle default")
                }
                
                
            }
        
        //MARK:- Functions
     func configureExploreTable() {
          forYouTable.dataSource=self
          forYouTable.delegate = self
          forYouTable.register(UINib(nibName: "forYouCell", bundle: nil), forCellReuseIdentifier: "forYouCellId")
      }
            
    func getPreferedArticles()
     {

        getPreferedSources { (sources) in
            self.sourcesRecieved.append(contentsOf: sources)
            self.getPreferedKeywords { (keywords) in
                self.keywordsRecieved.append(contentsOf: keywords)
                self.getPreferedLanguages { (languages) in
                    self.languagesRecieved.append(contentsOf: languages)
                    print("\(self.sourcesRecieved)\(self.languagesRecieved)\(self.keywordsRecieved)")
                    EveryThingService().getPreferedNews(sources: self.sourcesRecieved, languages: self.languagesRecieved, keywords: self.keywordsRecieved) { (result:Result<ArticlesModel, APIError>) in
                        
                        switch result
                        {
                        case .success(let articlesFiltered):
                            self.articlesForYou = articlesFiltered.articles
                            self.forYouTable.reloadData()
                        case .failure(let error):
                            print("HANDEL ERROR LATER ... \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
        
        }
            
        func getPreferedSources(completion : @escaping(_ sources:[String])->())
        {
            if  let currentUid = Firebase.Auth.auth().currentUser?.uid
            {
                let ref = Database.database().reference().child("users").child(currentUid)
                ref.child("favouriteSources").observe(.value) { (snapshot) in
                    guard let dataDic = (snapshot.value) as? [String : Any] else {return}
                    completion(dataDic.map{$0.key})
                }
            }
        }
        func getPreferedLanguages(completion : @escaping(_ languages:[String])->())
           {
               if  let currentUid = Firebase.Auth.auth().currentUser?.uid
               {
                   let ref = Database.database().reference().child("users").child(currentUid)
                   ref.child("preferedLanguages").observe(.value) { (snapshot) in
                       let dataDic = (snapshot.value) as! [String : Any]
                       completion(dataDic.map{$0.key})
                   }
               }
           }
        func getPreferedKeywords(completion : @escaping(_ keywords:[String])->())
        {
            if  let currentUid = Firebase.Auth.auth().currentUser?.uid
            {
                let ref = Database.database().reference().child("users").child(currentUid)
                ref.child("InterestsKeywords").observe(.value){ (snapshot) in
                      if    let keywords = (snapshot.value) as? [String : Any]
                      {  completion(keywords.map{$0.key})}
                }
            }
        }
    }


    //MARK:- Extensions
    //tableView
    extension ForYouVC:UITableViewDataSource, UITableViewDelegate
    {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return articlesForYou.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TagsTableViewCell", for: indexPath) as? TagsTableViewCell else { return TagsTableViewCell() }
            let article = articlesForYou [indexPath.row]
            
            cell.configureCell(with:article!)
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selectedIndex = indexPath
            
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if selectedIndex == indexPath
            {return UIScreen.main.bounds.height/1.5} else
            {return UIScreen.main.bounds.height/4.5
                
            }
        }
        
    }
