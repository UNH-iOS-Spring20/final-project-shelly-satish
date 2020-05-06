//
//  ChooseQtyView.swift
//  Healthify
//
//  Created by shelly choudhary on 02/04/20.
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

import UIKit

enum QuantityType: String {
    case water = "Water"
    case steps = "Steps"
    case setGoals = "Goals"
}

class ChooseQtyView: UIView {
    
    // MARK: - ▼▼▼ IBOUTLET Properties ▼▼▼
    @IBOutlet weak var txtFieldQty: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnSubtract: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    
    // MARK: - ▼▼▼ Properties ▼▼▼
    var type: QuantityType!
    var minValue: Int = 0
    var maxValue: Int = 0
    var count: Int = 0
    var completion: (() -> ())!

    static func showQtyView(type: QuantityType = .setGoals, callBack: @escaping () -> ()) {
        let view = ChooseQtyView().loadNib() as! ChooseQtyView
        view.completion = callBack
        view.type = type
        if type == .setGoals {
            view.btnAdd.isHidden = true
            view.btnSubtract.isHidden = true
            view.txtFieldQty.isEnabled = true
        }else {
            view.btnAdd.isHidden = false
            view.btnSubtract.isHidden = false
            view.txtFieldQty.isEnabled = false
            view.txtFieldQty.placeholder =  type == .water ? "Enter between 0-8L" : "Enter between 0-1000"
            view.maxValue = type == .water ? 8 : 1000
        }
        view.frame = UIScreen.main.bounds
        UIApplication.currentViewController()?.view.addSubview(view)
        view.animate()
    }
    
    
    // MARK: - ▼▼▼ PRIVATE METHODS ▼▼▼
    private func animate() {
        self.frame.origin.y = (UIApplication.currentViewController()?.view.frame.size.height)!
         self.viewBottomTopAnimation(tpview: (UIApplication.currentViewController()?.view)!)
     }
     
    
    // MARK: - ▼▼▼ IBOUTLET ACTION METHODS ▼▼▼
    @IBAction func btnClose_Action(_ sender: UIButton) {
        self.viewTopBottomAnimation(tpview: (UIApplication.currentViewController()?.view)!)
    }
    
    @IBAction func btnAdd_Action(_ sender: UIButton) {
        btnSubtract.isUserInteractionEnabled = true
        guard count != maxValue else  {
            txtFieldQty.text = "\(self.count)"
            btnAdd.isUserInteractionEnabled = false
            return
        }
        count += 1
        txtFieldQty.text = self.type == .water ? "\(self.count)" + "L"  : "\(self.count)"
        
    }
    
    @IBAction func btnSubtract_Action(_ sender: UIButton) {
        btnAdd.isUserInteractionEnabled = true
        guard count != minValue else  {
            txtFieldQty.text = "\(self.count)"
            btnSubtract.isUserInteractionEnabled = false
            return
        }
        count -= 1
        txtFieldQty.text = self.type == .water ? "\(self.count)" + "L"  : "\(self.count)"
    }
    
    @IBAction func btnDone_Action(_ sender: UIButton) {
        if txtFieldQty.text == "" {
            txtFieldQty.shake()
            return
        }
        //self.completion()
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let dbRef = appDelegate.dbRef?.child(kUsers).child(uid).child(kFitnessRegime) else {
            return
        }
        let value = type == .setGoals ? txtFieldQty.text! + "Kg" : txtFieldQty.text
        dbRef.updateChildValues([type.rawValue: value!]) { (err, dbRef) in
            guard err == nil else {return}
            Util.showAlertWithMessage("FITNESS_REGIME_UPDATED".localizeString(), title: Key_Alert.lowercased()) {
                LoaderView.kill()
                self.viewTopBottomAnimation(tpview: (UIApplication.currentViewController()?.view)!)
            }
        }
        
    }
}


// MARK: - ▼▼▼ EXTENSION TEXTFIELD-DELEGATE ▼▼▼
extension ChooseQtyView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let strCount = string.count + textField.text!.count 
        if self.type == .setGoals {
            if strCount <= 2 {
                return true
            }else {
                return false
            }
        }else {
            return true
        }
    }
}
