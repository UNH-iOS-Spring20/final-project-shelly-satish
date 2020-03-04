//
//  Total.swift
//  HealthMonitor
//
//  Created by shelly choudhary on 2/20/20.
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

class Total{
    var items = [BreakFast]()
    
    func addItem(calories: BreakFast){
        items.append(calories)
    }
    func returnTotal() -> Double{
        var total: Double = 0.0
        for calories in items{
            total += calories.calories
        }
        return total
    }
}
