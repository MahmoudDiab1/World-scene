//
//  ExploreTableViewCell.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {
  
    //    MARK:- Outlets
        @IBOutlet weak var sourceName: UILabel!
        @IBOutlet weak var authorName: UILabel!
        @IBOutlet weak var articleImage: UIImageView!
        @IBOutlet weak var articleContent: UITextView!
        @IBOutlet weak var backgroundCellView: UIView!
        @IBOutlet weak var articleTitle: UILabel!
    //    MARK:- Variabls
        
    //    MARK:- LifeCycle
        override func awakeFromNib() {
            super.awakeFromNib()
            
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            
        }
        
    //    MARK:- Functions
        
      func  configureCell(with article : article?) {
            sourceName.text = article?.source?.name
            authorName.text = article?.author
            articleTitle.text = article?.title
            articleContent.text = article?.description
            guard let urlString = article?.urlToImage else { return }
                   let url = URL(string: urlString)
                  articleImage.kf.setImage(with: url)
            backgroundCellView.layer.cornerRadius = .pi
      
            articleImage.layer.cornerRadius = .pi
        }
        
    }




    //
    //class TabBarController: UITabBarController {
    //
    //
    //public let coustmeTabBarView:UIView = {
    //
    //// daclare coustmeTabBarView as view
    //let view = UIView(frame: .zero)
    //
    //// to make the cornerRadius of coustmeTabBarView
    //view.backgroundColor = .white
    //view.layer.cornerRadius = 20
    //view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    //view.clipsToBounds = true
    //
    //// to make the shadow of coustmeTabBarView
    //view.layer.masksToBounds = false
    //view.layer.shadowColor = UIColor.lightGray.cgColor
    //view.layer.shadowOffset = CGSize(width: 0, height: -8.0)
    //view.layer.shadowOpacity = 0.12
    //view.layer.shadowRadius = 10.0
    //return view
    //}()
    //override func viewDidLoad() {
    //super.viewDidLoad()
    //// Do any additional setup after loading the view.
    //addcoustmeTabBarView()
    //hideTabBarBorder()
    //
    //
    //
    //}
    //
    //
    //func hideTab (){
    //self.coustmeTabBarView.alpha = 0
    //self.tabBar.isHidden = true
    //
    //}
    //func showTab (){
    //self.coustmeTabBarView.alpha = 1
    //self.tabBar.isHidden = false
    //
    //}
    //override func viewDidLayoutSubviews() {
    //super.viewDidLayoutSubviews()
    //coustmeTabBarView.frame = tabBar.frame
    //}
    //override func viewDidAppear(_ animated: Bool) {
    //var newSafeArea = UIEdgeInsets()
    //// Adjust the safe area to the height of the bottom views.
    //newSafeArea.bottom += coustmeTabBarView.bounds.size.height
    //// Adjust the safe area insets of the
    //// embedded child view controller.
    //self.children.forEach({$0.additionalSafeAreaInsets = newSafeArea})
    //}
    //private func addcoustmeTabBarView() {
    ////
    //coustmeTabBarView.frame = tabBar.frame
    //view.addSubview(coustmeTabBarView)
    //view.bringSubviewToFront(self.tabBar)
    //}
    //
    //
    //func hideTabBarBorder() {
    //let tabBar = self.tabBar
    //tabBar.backgroundImage = UIImage.from(color: .clear)
    //tabBar.shadowImage = UIImage()
    //tabBar.clipsToBounds = true
    //}
    //
    //}
    //extension UIImage {
    //static func from(color: UIColor) -> UIImage {
    //let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    //UIGraphicsBeginImageContext(rect.size)
    //let context = UIGraphicsGetCurrentContext()
    //context!.setFillColor(color.cgColor)
    //context!.fill(rect)
    //let img = UIGraphicsGetImageFromCurrentImageContext()
    //UIGraphicsEndImageContext()
    //return img!
    //}
    //}
