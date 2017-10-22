//
//  ViewController.swift
//  GuiltyPleasures
//
//  Created by Lucy Tan on 10/21/17.
//  Copyright © 2017 Lucy Tan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
    
    @IBAction func apicall(_ sender: UIButton) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://syf2020.syfwebservices.com/v1_0/loyalty") as! URL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let bodyString = "{\"accountNumber\": 1337 , \"sku\": \"item-1234\", \"totalPriceRequested\": 1}"
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
            
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            print(json)
            let offer = json!["offer"] as? [[String: Any]]
            print(offer)
            
//            if let string = String(data: data, encoding: .utf8){
//                let jsondata = [string]
//                if let json = try? JSONSerialization.data(withJSONObject: jsondata, options: []) {
//                    print(json)
//                }
//            }
            
            
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

