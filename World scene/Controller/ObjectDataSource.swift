//
//  file.swift
//  World scene
//
//  Created by mahmoud diab on 6/29/20.
//  Copyright © 2020 Diab. All rights reserved.
//
import Foundation
import UIKit

 class ObjectDataSource: NSObject, UITableViewDataSource {
    var objects = [Any]()

 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = objects[indexPath.row] as! NSDate
        cell.textLabel!.text = object.description
        return cell
    }
 
}
