//
//  Orders.swift
//  Restaurant
//
//  Created by Chinonso Obidike on 3/21/19.
//  Copyright © 2019 Chinonso Obidike. All rights reserved.
//

import Foundation

struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
