//
//  LoginVC.swift
//  HealthyApp
//
//  Created by shelly choudhary on 25/03/20.
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    // MARK: - ▼▼▼ IBOUTLET Properties ▼▼▼
    @IBOutlet weak var constAppLogoTop: NSLayoutConstraint!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnCreateAccount: UIButton!
    
    // MARK: - ▼▼▼ Properties ▼▼▼
    var loginVM = LoginVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func login() {
        
        LoaderView.show()
        Auth.auth().signIn(withEmail: txtFieldEmail.text!, password: txtFieldPassword.text!) { [weak self] authResult, error in
            guard let weakSelf = self else {
                LoaderView.kill()
                Util.showAlertWithMessage(error!.localizedDescription, title: Key_Alert)
                return
            }
            LoaderView.kill()
            LoggedInUser.shared.retrieveDataFromFireBase { (success) in
                if success {
                    weakSelf.navigationController?.pushViewController(Storyboard.dashboard.instantaite(TabBarVC.self), animated: true)
                }else{
                    Util.showAlertWithMessage("SOMETHING_WENT_WRONG_WITH_WRONG_PASS".localizeString(), title: Key_Alert.localizeString())
                }
            }
            
        }

    }
    
    private func checkIfUserExists() {
        
        appDelegate.dbRef?.child(kUsers).queryOrdered(byChild: "eamilId").queryEqual(toValue: self.txtFieldEmail.text!).observe(.value, with: { [weak self] snapshot in
            if !snapshot.exists(){
                Util.showAlertWithMessage("USER_INVALID".localizeString(), title: Key_Alert.localizeString())
            }else {
                self?.login()
            }

        })
        
    }
    
    //MARK: - Action Method
     @IBAction func btnForgotPassword_Action(_ sender: Any) {
        navigationController?.pushViewController(Storyboard.onboarding.instantaite(ForgotPasswordVC.self), animated: true)
     }
     
     @IBAction func btnCreateAccount_Action(_ sender: Any) {
        navigationController?.pushViewController(Storyboard.onboarding.instantaite(SignUpVC.self), animated: true)
     }
     
     @IBAction func btnNext_Action(_ sender: Any) {
          guard loginVM.isvalid(txtFieldEmail.text!, txtFieldPassword.text!) else {  return }
          checkIfUserExists()
        
     }
     
    @IBAction func btnChangeLang_action(_ sender: Any) {
        navigationController?.setViewControllers([Storyboard.onboarding.instantaite(ChangeLanguageVC.self)], animated: true)
    }



}
