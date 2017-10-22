//
//  ViewController.swift
//  GuiltyPleasures
//
//  Created by Lucy Tan on 10/21/17.
//  Copyright © 2017 Lucy Tan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBAction func apicall(_ sender: UIButton) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://syf2020.syfwebservices.com/v1_0/next_purchase") as! URL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let bodyString = "{\"accountNumber\": 1337 }"
        let bodyData = bodyString.data(using: .utf8)
        
        request.httpMethod = "POST"
        request.httpBody = bodyData
        
        print(NSString(data: request.httpBody!, encoding: String.Encoding.utf8.rawValue)!)
        print(request.allHTTPHeaderFields!)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            print(data!)
            print(response!)
            guard error == nil else {
                print(error)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            print(json)
            let jsonString = String(describing: json)
            
            print(jsonString)
        }
        
        task.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

