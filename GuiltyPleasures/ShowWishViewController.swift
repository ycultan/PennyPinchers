//
//  ShowWishViewController.swift
//  GuiltyPleasures
//
//  Created by Lucy Tan on 10/22/17.
//  Copyright © 2017 Lucy Tan. All rights reserved.
//

import UIKit
import CoreData

class ShowWishViewController: UIViewController {
    
    var items: [Any] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print(items)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ShowWishViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "wishTableCell") as! CustomWishCell
        let item = items[indexPath.row] as! Item
        cell.nameLabel.text! = item.title!
        cell.detailsLabel.text! = item.desc!
        cell.barcode.text! = item.barcode!
        return cell
    }
}
