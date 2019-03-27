//
//  MenuController.swift
//  Restaurant
//
//  Created by Chinonso Obidike on 3/21/19.
//  Copyright © 2019 Chinonso Obidike. All rights reserved.
//

import Foundation

class MenuController {
    let baseURL = URL(string: "http://localhost:8090")!
   static let shared = MenuController()
    
    var order = Order() {
        didSet {
        NotificationCenter.default.post(name: MenuController.orderUpdatedNotification, object: nil)
    }
    }
    
    static let orderUpdatedNotification = Notification.Name("MenuController.orderUpdated")
    
    
    
    
    
    
    
    
    
func fetchCategories(completion: @escaping([String]?) -> Void) {
    let categoryURL = baseURL.appendingPathComponent("categories")
    let task = URLSession.shared.dataTask(with: categoryURL) {
       (data: Data?, response: URLResponse?, error: Error?) in
        if let data = data,
            let jsonDictionary = try?
                JSONSerialization.jsonObject(with: data) as? [String: Any],
            let categories = jsonDictionary?["categories"] as? [String] {
            completion(categories)
        } else {
            completion(nil)
        }
    }
    task.resume()
}
func fetchMenuItems(forCategory categoryName: String,
                    completion: @escaping
                    ([MenuItem]?)-> Void) {
    let initialMenuURL = baseURL.appendingPathComponent("menu")
    print("menu url:  \(initialMenuURL)")
    var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
    components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
    print("category:  \(categoryName)")
    let menuURL = components.url!
        
        //fatalError("could not crate menuURL")
   // }
    print("menu url:  \(menuURL)")
    let task = URLSession.shared.dataTask(with: menuURL) {
        (data: Data?, response: URLResponse?, error: Error?) in
                let jsonDecoder = JSONDecoder()
        print("decoder:  \(jsonDecoder)")
        
        if let data = data,
            let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
            print("menu items:  \(menuItems)")

            completion(menuItems.items)
        } else {
            print("menu nil:  nil)")
            completion(nil)
        }
    }
task.resume()    
}

func submitOrder(forMenuIDs menuIDs: [Int],
                 completion: @escaping(Int?) -> Void) {
    let orderURL = baseURL.appendingPathComponent("order")
    var request = URLRequest(url: orderURL)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let data: [String: [Int]] = ["menuIds": menuIDs]
    let jsonEncoder = JSONEncoder()
    let jsonData = try? jsonEncoder.encode(data)
    request.httpBody = jsonData
    let task = URLSession.shared.dataTask(with: request) {
        (data: Data?, response: URLResponse?, error: Error?) in
        let jsonDecoder = JSONDecoder()
        if let data = data,
            let preparationTime = try?
                jsonDecoder.decode(PreparationTime.self, from: data) {
            completion(preparationTime.prepTime)
        } else {
            completion(nil)
        }
        
    }
    task.resume()
}
}
