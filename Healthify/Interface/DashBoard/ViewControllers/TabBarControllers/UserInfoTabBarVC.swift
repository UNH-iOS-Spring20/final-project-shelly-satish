//
//  UserInfoTabBarVC.swift
//  HealthyApp
//
//  Created by shelly choudhary on 25/03/20.
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

import UIKit

class UserInfoTabBarVC: UIViewController {
    
    // MARK: - ▼▼▼ IBOUTLET Properties ▼▼▼
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblEmailId: UILabel!
    @IBOutlet weak var btnMyPlan: UIButton!
    @IBOutlet weak var btnTracker: UIButton!
    @IBOutlet weak var btnSupport: UIButton!
    @IBOutlet weak var btnHealthyMeal: UIButton!
    @IBOutlet weak var btnReminder: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialSetup()
    }
    
    
    private func initialSetup() {
        lblUserName.text = LoggedInUser.shared.firstName + " " + LoggedInUser.shared.lastName
        lblEmailId.text = LoggedInUser.shared.emailId
        btnEdit.setTitle("EDIT".localizeString(), for: .normal)
        btnTracker.setTitle("TRACKER".localizeString(), for: .normal)
        btnSupport.setTitle("SUPPORT".localizeString(), for: .normal)
        btnHealthyMeal.setTitle("HEALTHY_MEAL".localizeString(), for: .normal)
        btnMyPlan.setTitle("MY_PLAN".localizeString(), for: .normal)
        btnReminder.setTitle("REMINDER".localizeString(), for: .normal)
    }
    
    
    // MARK: - ▼▼▼ IBOUTLET ACTIONS ▼▼▼
    
    @IBAction func btnMyPlan_Action(_ sender: Any) {
        
    }

    @IBAction func btnTracker_Action(_ sender: Any) {
          
      }
    
    @IBAction func btnSupport_Action(_ sender: Any) {
          
      }
    
    @IBAction func btnHealthyMeal_Action(_ sender: Any) {
          
      }
    
    @IBAction func btnReminder_Action(_ sender: Any) {
          
      }

}
