//
//  ExploreVC.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit

class ExploreVC: UIViewController {
    
    //    MARK:- Outlets
    @IBOutlet weak var searchNews: UISearchBar!
    @IBOutlet weak var exploreCollection: UICollectionView!
    @IBOutlet weak var exploreTable: UITableView!
    //    MARK:- Variables
    var selectedArticle:article?
    let  newsCategories = [
        "business","entertainment","general",
        "health","science","sports","technology"
    ]
    
    var exploreData=[article?]()
    var searchKeyword :String?
    var selectedIndex:IndexPath?
    
    //    MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureExploreTable()
        configureExploreCollection()
        configureSearchNews()
        search(keyword: "explore")
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //    MARK:- Functions
    @IBAction func signOutPressed(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isSignedIn")
        dismiss(animated: true, completion:nil)
    }
    func configureExploreTable() {
        exploreTable.dataSource = self
        exploreTable.delegate = self
        exploreTable.register(UINib(nibName: "ExploreTableViewCell", bundle: nil), forCellReuseIdentifier: "ExploreTableViewCell")
    }
    func configureExploreCollection()  {
        exploreCollection.dataSource = self
        exploreCollection.delegate = self
        exploreCollection.register(UINib(nibName: "ExploreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ExploreCollectionViewCell")
    }
    
    func configureSearchNews() {
        searchNews.delegate = self
    }
    
    func search(keyword:String?)  {
        EveryThingService().search(Entry: keyword) { (result:Result<ArticlesModel,APIError>) in
            switch result  {
            case .success(let articles):
                self.exploreData = articles.articles
                self.exploreTable.reloadData()
            case .failure(let error):
                print("ERROR TO HANDEL \(error.localizedDescription)")
                self.exploreTable.reloadData()
            }
        }
    }
    @objc  func oneTapped(_ sender:UIButton? ) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ArticleVC") as! ArticleVC
        vc.article = exploreData[sender!.tag]
        vc.articleType = "article"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



//MARK:- Extensions
//tableView
extension ExploreVC : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exploreData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreTableViewCell", for: indexPath) as? ExploreTableViewCell else { return ExploreTableViewCell() }
        let article = exploreData[indexPath.row]
        cell.moreDetailsButton.addTarget(self, action: #selector(ExploreVC.oneTapped(_:)), for: .touchUpInside)
        cell.moreDetailsButton.tag = indexPath.row
        cell.configureCell(with: article)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndex == indexPath
        {return UIScreen.main.bounds.height/2} else
        {return UIScreen.main.bounds.height/4.5
            
        }
    }
}

//collectionView
extension ExploreVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  let item = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCollectionViewCell", for: indexPath) as? ExploreCollectionViewCell else { return ExploreCollectionViewCell() }
        let category = newsCategories[indexPath.item]
        item.configureItem(with: category )
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth :CGFloat = ( view.frame.width-5)/2.6
        let itemHeight :CGFloat = ( view.frame.height-5)/2.6
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = newsCategories[indexPath.item]
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCollectionViewCell", for: indexPath) as! ExploreCollectionViewCell
        item.layer.backgroundColor = UIColor.red.cgColor
        search(keyword: category)
    }
}

//searchBar
extension ExploreVC : UISearchBarDelegate  {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let keyword = searchBar.text
        search(keyword: keyword)
        searchBar.searchTextField.resignFirstResponder()
    }
}
