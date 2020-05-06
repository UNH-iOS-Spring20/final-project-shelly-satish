//
//  SignupVC.swift
//  HealthyApp
//
//  Created by shelly choudhary on 25/03/20.
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

import UIKit
import FirebaseCoreDiagnostics

class SignUpVC: UIViewController {
    
    // MARK: - ▼▼▼ IBOUTLET Properties ▼▼▼
    @IBOutlet weak var constLblTop: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnCountryCode: UIButton!
    @IBOutlet var txtFlds: Array<UITextField>!
    
    
    // MARK: - ▼▼▼ Properties ▼▼▼
    var signupVM = SignupVM()
    var codeInfo: ListDetail = ListDetail(name: "India", code: "+91",id: 0, isoCode: "IND")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    private func registerUser() {
        
        LoaderView.show()
        Auth.auth().createUser(withEmail: txtFlds[2].text!, password: txtFlds[3].text!) { [weak self] authResult, error in
            LoaderView.kill()
            guard let user = authResult?.user, error == nil else {
                Util.showAlertWithMessage(error!.localizedDescription, title: Key_Alert)
                return
            }
            let zipcode: String = self?.btnCountryCode.titleLabel!.text ?? ""
            let userData: HTTPParameters = ["firstName": self?.txtFlds[0].text ?? "",
                            "lastName": self?.txtFlds[1].text ?? "",
                            "zipCode": zipcode,
                            "eamilId": self?.txtFlds[2].text ?? "",
                            "country": self?.txtFlds[4].text ?? ""
                ] as HTTPParameters
            let ref = Database.database().reference()
            ref.child(kUsers).child(authResult!.user.uid).setValue(userData)
            LoggedInUser.shared.retrieveDataFromFireBase { (success) in
                if success {
                   self?.navigationController?.pushViewController(Storyboard.dashboard.instantaite(TabBarVC.self), animated: true)
                }
            }
            
            print("\(user.email!) created")
            
        }
    }
    
    
    
    
    // MARK: - ▼▼▼ Action Methods ▼▼▼
    @IBAction func btnCountryCodeAction(_ sender: Any) {
        view.endEditing(true)
        ListView.initialize(lastSelected: codeInfo, type: .countryCode) { [weak self] (codes) in
            guard let weakSelf = self else {return}
            weakSelf.btnCountryCode.setTitle(codes.code, for: .normal)
            weakSelf.codeInfo = codes
            weakSelf.txtFlds[4].text = codes.name
        }
        
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        guard signupVM.isValid(txtFlds) else { return }
        registerUser()
        
    }
    
    @IBAction func btnSignInAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTC_Action(_ sender: Any) {
    }
    
    
    
    
}
