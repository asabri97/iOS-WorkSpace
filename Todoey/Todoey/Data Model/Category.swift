//
//  Category.swift
//  Todoey
//
//  Created by Abrish Sabri on 9/10/19.
//  Copyright © 2019 Abrish Sabri. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name: String = ""
    @objc dynamic var colour : String = ""
    
    let items = List<Item>()
    
}
