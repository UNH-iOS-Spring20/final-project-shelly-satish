//
//  CustomerCal.swift
//  HealthMonitor
//
//  Created by shelly choudhary on 2/20/20.
//  Copyright © 2020 shelly choudhary. All rights reserved.
//
class BreakFast{
    var item: String
    var quantity:Double
    var calories:Double
    init(item: String,quantity:Double,calories:Double){
//        if item.isEmpty || calories < 0 {
//            return nil
//    }
        self.item = item
        self.quantity = quantity
        self.calories = calories
    }
}
