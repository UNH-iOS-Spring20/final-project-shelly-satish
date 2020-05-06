//
//  HomeTabBarVC.swift
//  HealthyApp
//
//  Created by shelly choudhary on 25/03/20.
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

import UIKit

class HomeTabBarVC: UIViewController {
    
    // MARK: - ▼▼▼ IBOUTLET PROPERTIES ▼▼▼
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitleOne: UILabel!
    @IBOutlet weak var lblSubTitleTwo: UILabel!
    @IBOutlet weak var lblSubTitleThree: UILabel!
    @IBOutlet weak var lblSubTitleFour: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configAppeareance()
    }
    
    // MARK: - ▼▼▼ PRIVATE FUNCTIONS ▼▼▼
    private func configAppeareance() {
        lblTitle.text = "HEALTHIFY".localizeString()
        lblSubTitleOne.text = "CAL_EATEN".localizeString()
        lblSubTitleTwo.text = "WATER".localizeString()
        lblSubTitleThree.text = "STEPS".localizeString()
        lblSubTitleFour.text = "GOALS".localizeString()
        
    }
    
    
    // MARK: - ▼▼▼ IBOUTLET ACTIONS ▼▼▼
    @IBAction func btnWater_action(_ sender: UIButton) {
        ChooseQtyView.showQtyView(type: .water, callBack: {
            print("removed")
        })
    }
    
    @IBAction func btnSteps_action(_ sender: UIButton) {
        ChooseQtyView.showQtyView(type: .steps, callBack: {
            print("removed")
        })
    }
    
    @IBAction func btnCal_Eaten_action(_ sender: UIButton) {
        self.navigationController?.pushViewController(Storyboard.dashboard.instantaite(CaloriesEatenViewController.self), animated: true)
    }
    
    @IBAction func btnGoals_action(_ sender: UIButton) {
        ChooseQtyView.showQtyView(callBack: {
            print("removed")
        })
    }
    
}

//2.databaseRef.child("appData").child("appModule").setValue esa krne se ek node aur create ho jayega

