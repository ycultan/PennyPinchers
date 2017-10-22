//
//  WishCollection.swift
//  GuiltyPleasures
//
//  Created by Lucy Tan on 10/22/17.
//  Copyright © 2017 Lucy Tan. All rights reserved.
//

import UIKit

struct Item {
    var title: String?
    var desc: String?
    var barcode: String?
}

class WishCollection: UIViewController {
    
    var items: [Item] = []
    var item = Item()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var urlTextField: UITextField!
    
    @IBAction func addWishButtonPressed(_ sender: UIButton) {
        let request = NSMutableURLRequest(url: NSURL(string: "http://localhost:8000/amazon")! as URL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let bodyString = "{\"url\":\"\(urlTextField.text!)\"}"
        let bodyData = bodyString.data(using: .utf8)
        
        request.httpMethod = "POST"
        request.httpBody = bodyData
        
        print(NSString(data: request.httpBody!, encoding: String.Encoding.utf8.rawValue)!)
        print(request.allHTTPHeaderFields!)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil else {
                print(error)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            
            let backToString = String(data: data, encoding: String.Encoding.utf8) as String!
            print("yomama", backToString)
            self.item.title = backToString
            self.getCoupon()
        }
            
        task.resume()
        
        
        

    }
    
    func getCoupon() {
        let request2 = NSMutableURLRequest(url: NSURL(string: "http://localhost:8000/loyalty") as! URL)
        request2.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let bodyString2 = "{\"accountNumber\": 1337 , \"sku\": \"item-1234\", \"totalPriceRequested\": 1}"
        let bodyData2 = bodyString2.data(using: .utf8)
        
        request2.httpMethod = "POST"
        request2.httpBody = bodyData2
        
        let task2 = URLSession.shared.dataTask(with: request2 as URLRequest) { data, response, error in
            guard error == nil else {
                print(error)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            print("json: ", json)
            let offer = json!["offer"] as! NSDictionary
            self.item.desc = offer["description"] as? String
            self.item.barcode = "\(offer["barcode"]!)"
            print("bar", offer["barcode"], "desc", offer["description"])
            
            print("item", self.item)
            self.items.append(self.item)
            print("items", self.items)
            self.tableView.reloadData()
            
        }
        
        task2.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension WishCollection: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wishTableCell") as! CustomWishCell
        let item = items[indexPath.row]
        cell.nameLabel.text! = item.title!
        cell.detailsLabel.text! = item.desc!
        cell.barcode.text! = item.barcode!
        return cell
    }
}
