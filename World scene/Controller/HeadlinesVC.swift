//
//  HeadlinesVC.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit
  

class HeadlinesVC: UIViewController {
  
    //MARK:- Outlets-
        @IBOutlet weak var headlinesCategoriesCollectionView: UICollectionView!
        @IBOutlet weak var headlinesTableView: UITableView!
    
    
        //MARK:- variables-
         
 
    let newsCategories=[
            "business","entertainment","general",
            "health","science","sports","technology"
        ]
         let languageOptions = ["kj","sd","ds","ds","ds"]
        var headlinesDataSource = [Headline?]()
        var country="us"
    
        //MARK:- Lifecycle
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
         setupScene()
            
                  
            
             
                   
                   
             
        }
        override func viewDidLoad() {
            super.viewDidLoad()
    }
        
        //    MARK:- Actions
        @IBAction func signOut(_ sender: Any) {
            UserDefaults.standard.set(false, forKey: "isSignedIn")
            dismiss(animated: true, completion:nil)
        }
        
        
        //    MARK:- Functions
        
        func setupScene() {
//           headlinesTableView.allowsSelection = true
           headlinesTableView.dataSource = self
           headlinesTableView.delegate = self
           headlinesTableView.register(UINib.init(nibName: "HeadlineTableViewCell", bundle:nil), forCellReuseIdentifier: "HeadlineTableViewCell")
            
           headlinesCategoriesCollectionView.dataSource=self
           headlinesCategoriesCollectionView.delegate=self
           headlinesCategoriesCollectionView.register(UINib.init(nibName:"HeadlineCategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HeadlineCategoriesCollectionViewCell")
            
            TopHeadlineServices.topHeadlinesDeafault(country: "us") { (result:Result<HeadlinesModel, APIError>) in
                switch result {
                case .success(let responseResult):
                    self.headlinesDataSource = responseResult.articles!
                    self.headlinesTableView.reloadData()
                case .failure:
                    print("Handle it later")
                }
            }
            
        }
    }

    //    MARK:- extensions

    //TableView
    extension HeadlinesVC:UITableViewDataSource, UITableViewDelegate  {
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return (UIScreen.main.bounds.height/2)
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return headlinesDataSource.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell  = tableView.dequeueReusableCell(withIdentifier: "HeadlineTableViewCell", for: indexPath) as? HeadlineTableViewCell
                else { return HeadlineTableViewCell() }
            cell.configureCell(article: headlinesDataSource[indexPath.row],flage:true)
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            DispatchQueue.main.async {
                 
                let article = self.headlinesDataSource[indexPath.row]
                let vc = self.storyboard?.instantiateViewController(identifier: "ArticleVC") as! ArticleVC
                vc.article=article
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }

    //Collection View
    extension HeadlinesVC:UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout
    {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return newsCategories.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let item=collectionView.dequeueReusableCell(withReuseIdentifier: "HeadlineCategoriesCollectionViewCell", for: indexPath) as! HeadlineCategoriesCollectionViewCell
            item.headlinesCategoryLable.text=newsCategories[indexPath.item]
            return item
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  { 
            let selectedCategory=newsCategories[indexPath.item]
            TopHeadlineServices.HeadlinesCategoryCountry(country: "us", category: selectedCategory) { (result:Result<HeadlinesModel, APIError>) in
                switch result
                {
                case .success(let responseResult):
                    self.headlinesDataSource = responseResult.articles!
                    self.headlinesTableView.reloadData()
                case .failure:
                    print("Handle it later")
                }
            }
        }
        
    }
