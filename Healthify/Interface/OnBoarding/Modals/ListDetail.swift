//
//  ListDetail.swift
//
//  Created by shelly choudhary on 16/02/18.
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

import Foundation


struct ListDetail {
    
    var name: String!
    var code: String!
    var id: Int!
    var isoCode: String!
    var isSelected: Bool = false
    
    init(name: String, code: String! = "", id: Int?, isoCode: String! = "OM") {
        self.name = name
        self.code = code
        self.id = id
        self.isoCode = isoCode
    }
    
}
