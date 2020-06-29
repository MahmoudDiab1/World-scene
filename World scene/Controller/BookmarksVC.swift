//
//  BookmarksVC.swift
//  World scene
//
//  Created by mahmoud diab on 6/28/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit
import CoreData
class BookmarksVC: UIViewController  {
    
    //MARK:- Outlets -
    @IBOutlet weak var BookMarks: UITableView!
     
    @IBOutlet weak var bookMarksMsgLable: UILabel!
    //MARK:- Variables -
    //    var bookMarksData = [Headline]()
    var fetchedArticles = [Article]()
    let  appDelegate =  UIApplication.shared.delegate as! AppDelegate
    
    
    //MARK:- LifeCycle -
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupScene()
        BookMarks.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    //MARK:- Functions -
    func setupScene () {
        
        fetchBookmarks()
        BookMarks.dataSource = self
        BookMarks.delegate = self
        BookMarks.register(UINib.init(nibName: "HeadlineTableViewCell", bundle:nil), forCellReuseIdentifier: "HeadlineTableViewCell")
    }
    @IBAction func signOutPressed(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isSignedIn")
        dismiss(animated: true, completion:nil)
    }
    
    func fetchBookmarks () {
        let viewContext = appDelegate.persistentContainer.viewContext
        let  fetchRequest = NSFetchRequest<Article>(entityName: "Article")
        do {
            fetchedArticles = try viewContext.fetch(fetchRequest)
            try viewContext.save()
        }  catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func deleteBookMark (at indexPath:IndexPath) {
 
        do {
            let viewContext = appDelegate.persistentContainer.viewContext
             let deletedArticle  = fetchedArticles.remove(at: indexPath.row)
             
             viewContext.delete(deletedArticle)
            try  viewContext.save()
            
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}




//MARK:- Extensions
//TableView Functions for delegate - dataSource
extension BookmarksVC:UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (UIScreen.main.bounds.height/2)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "HeadlineTableViewCell", for: indexPath) as? HeadlineTableViewCell
            else { return HeadlineTableViewCell() }
        cell.configureBookMarkCell(article:  fetchedArticles[indexPath.row] )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let article = fetchedArticles[indexPath.row]
       let vc = storyboard?.instantiateViewController(identifier: "ArticleVC") as! ArticleVC
        
        vc.Bookmark = article
        vc.articleType = "Article"
        navigationController?.pushViewController(vc, animated: true)
    }
     
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        let style = UITableViewCell.EditingStyle.none
        return style
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "DELETE") { (action, view, handler) in
            self.deleteBookMark(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.fetchBookmarks()
            tableView.reloadData()
        } 
        deleteAction.backgroundColor = .black
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
}
