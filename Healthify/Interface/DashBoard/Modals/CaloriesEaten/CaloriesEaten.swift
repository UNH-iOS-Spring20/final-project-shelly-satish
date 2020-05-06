//
//  CaloriesEaten.swift
//  Healthify
//
//  Created by shelly choudhary on 18/04/20.
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

import Foundation

struct CaloriesEaten {
    
    var isExpanded: Bool = false
    var title: String?
    var name:[String]?
    
    init(title: String, name: [String]) {
        self.title = title
        self.name = name
    }
    
    static func prepapreDataSource() -> [CaloriesEaten] {
        return CaloriesEaten.arrCalDetail
    }
    
    static var arrCalDetail: [CaloriesEaten] {
        
        return [CaloriesEaten(title: "BREAKFAST", name: ["Bread Jam", "Sandwich", "Milk/Eggs", "Omlette"]),
                CaloriesEaten(title: "MORNING SNACK", name: ["Samosa", "Idli/Sambhar", "Pohe", "Aloo Ka Parantha"]),
                CaloriesEaten(title: "LUNCH", name: ["Fried Rice with Veggies", "Chicken Biriyani", "Chapati/Veggies/Salads", "Rajma/Chawal"]),
                CaloriesEaten(title: "EVENING SNACK", name: ["Oats", "Peanut-Butter Sandwich", "Sweet Potatoes with milk", "Protien Shake"]),
                CaloriesEaten(title: "DINNER", name: ["Boiled Eggs with Veggies and Rice", "Chapati/Sabji", "Vegetable Biriyani with Sweets", "Cheese Omlette"])
        ]
        
    }
    
}
