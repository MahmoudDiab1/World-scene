//
//  SourcesVC.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit

class SourcesVC: UIViewController {
  
        //    MARK:- Outlets
    @IBOutlet weak var sourcesList: UITableView!
    
        //        MARK:- variables
        var sourcesArrayList=[Source]()
        var indexSelected:IndexPath?
        //        MARK:- lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            
          configureSourcesTable()
        }
        
        //    MARK:- Actions
        
        //    MARK:- Functions
        
        func configureSourcesTable()
        {
            sourcesList.dataSource=self
            sourcesList.delegate=self
            sourcesList.register(UINib.init(nibName:"sources", bundle: nil), forCellReuseIdentifier: "sourcesCell")
            
            NetworkEngine.fetchData(serviceEndPoint: SourcesEndPoint.getsources) { ( result:Result<SourcesModle,APIError> ) in
                switch result
                {
                case .success(let sourcesResult):
                    
                    self.sourcesArrayList=sourcesResult.sources
                    self.sourcesList.reloadData()
                case .failure(let error):
                    print("handel getting resources error in customize feed -----> \(error)")
                }
            }
            
        }
        
        
    }
    //MARK:- extensions
    extension SourcesVC:UITableViewDataSource, UITableViewDelegate
    {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return sourcesArrayList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard  let cell=tableView.dequeueReusableCell(withIdentifier: "SourcesTableViewCell", for: indexPath) as? SourcesTableViewCell
            else { return SourcesTableViewCell() }
            let source = sourcesArrayList[indexPath.row]
            cell.configureCell(with: source)
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            indexSelected=indexPath

            tableView.beginUpdates()
            tableView.endUpdates()
            
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            if indexPath == indexSelected{
                
                return 250
            }
            return 100
        }
        
        
    }
