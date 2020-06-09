//
//  Genre.swift
//  Demo_Chat
//
//  Created by HungNV on 8/14/17.
//  Copyright © 2017 HungNV. All rights reserved.
//

import Foundation

struct Genre {
    var id: Int
    var name:String = ""
    
    init?(jsonData: JSONData) {
        guard let id = jsonData["id"] as? Int else {return nil}
        self.id = id
        
        if let name = jsonData["name"] as? String {
            self.name = name
        }
    }
}
