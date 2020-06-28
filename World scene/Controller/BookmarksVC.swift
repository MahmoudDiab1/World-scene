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
    
    
    //MARK:- Variables -
    var bookMarksData = [Headline]()
    var fetchedArticles = [Article]()
    let  appDelegate =  UIApplication.shared.delegate as! AppDelegate
    
    
  //MARK:- LifeCycle -
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        BookMarks.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
    }
    
    
    //MARK:- Functions -
    func setupScene () {
        fetchBookmarks()
        BookMarks.dataSource = self
        BookMarks.delegate = self
        BookMarks.register(UINib.init(nibName: "HeadlineTableViewCell", bundle:nil), forCellReuseIdentifier: "HeadlineTableViewCell")
    }
    
    func fetchBookmarks () {
        let viewContext = appDelegate.persistentContainer.viewContext
        let  fetchRequest = NSFetchRequest<Article>(entityName: "Article")
        do {
            fetchedArticles =   try viewContext.fetch(fetchRequest)
            for i in fetchedArticles {
                let source = headlineSource(id: i.sourceId, name: i.sourceName)
                let article = Headline(source: source, author: i.authorName, title: i.articleTitle, description: i.description, url: i.articleUrl, urlToImage: i.urlToImage, publishedAt: i.datePublished, content: i.articleContent)
                bookMarksData.append(article)
                do{   try viewContext.save()}
                catch{debugPrint(fatalError(error.localizedDescription))}
            }
        } catch {fatalError(error.localizedDescription) }
    }
    
    
    func deleteBookMark (at indexPath:IndexPath) {
        let viewContext = appDelegate.persistentContainer.viewContext
        let deletedArticle  = fetchedArticles.remove(at: indexPath.row)
        viewContext.delete(deletedArticle)
  _ = bookMarksData.remove(at: indexPath.row)
    
        do {
            try  viewContext.save()
            BookMarks.reloadData()
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
        return bookMarksData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "HeadlineTableViewCell", for: indexPath) as? HeadlineTableViewCell
            else { return HeadlineTableViewCell() }
        cell.configureCell(article: bookMarksData[indexPath.row],flage: false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = bookMarksData[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "ArticleVC") as! ArticleVC
        
        vc.article = article
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
            tableView.reloadData()
            self.fetchBookmarks()
        }
        
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
     
}
