//
//  FitnessRegime.swift
//  Healthify
//
//  Created by shelly choudhary on 03/05/20.
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

import Foundation


struct FitnessRegime {
    
    var water: String = ""
    var steps: String = ""
    var goals: String = ""
    var breakFast: String = ""
    var morningsnack: String = ""
    var dinner: String = ""
    var eveningSnack: String = ""
    var lunch: String = ""
    
    static func fetchUsersDetailDB(dict: NSDictionary) -> FitnessRegime {
        let fitnessRegime = FitnessRegime(dict: dict)
        return fitnessRegime
    }
    
    init(dict: NSDictionary) {
        
        self.water = dict["Water"] as? String ?? ""
        self.steps = dict["Steps"] as? String ?? ""
        self.goals = dict["Goals"]  as? String ?? ""
        self.breakFast = dict["BREAKFAST"] as? String ?? ""
        self.dinner = dict["DINNER"] as? String ?? ""
        self.morningsnack = dict["MORNING SNACK"] as? String ?? ""
        self.eveningSnack = dict["EVENING SNACK"]  as? String ?? ""
        self.lunch = dict["LUNCH"]  as? String ?? ""
        
    }
    
}
