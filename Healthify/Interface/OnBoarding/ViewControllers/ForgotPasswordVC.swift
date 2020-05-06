//
//  ForgotPasswordVC.swift
//  HealthyApp
//
//  Created by shelly choudhary on 25/03/20.
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    @IBOutlet weak var txtFieldEmail: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnBack_Action(_ sender: Any) {
           self.navigationController?.popViewController(animated: true)
       }
       
       
       @IBAction func btnNext_Action(_ sender: Any) {
           view.endEditing(true)
           //guard forgotPassVM.isvalid(txtFieldEmail.text!) else {return}
           //forgotPasswordApi()
       }
    
}
