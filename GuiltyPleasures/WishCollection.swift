//
//  WishCollection.swift
//  GuiltyPleasures
//
//  Created by Lucy Tan on 10/22/17.
//  Copyright © 2017 Lucy Tan. All rights reserved.
//

import UIKit

class WishCollection: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!
    
    @IBAction func addWishButtonPressed(_ sender: UIButton) {
        let request = NSMutableURLRequest(url: NSURL(string: "localhost:8000/amazon") as! URL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let bodyString = "{\"url\":\" \(urlTextField.text!) \"}"
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
            
            let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            print("json: ", json)
        }
            
        task.resume()
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
