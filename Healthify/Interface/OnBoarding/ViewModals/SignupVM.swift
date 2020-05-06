//
//  SignupVM.swift
//  Azooz
//
//  Created by shelly choudhary on 07/09/18.
//  Copyright © shelly choudhary. All rights reserved.
//

import Foundation
import UIKit

class SignupVM {

    func isValid(_ txtFlds: Array<UITextField>) -> Bool {
        
        if (txtFlds[0].text?.isEmpty)! {
            Util.showAlertWithMessage(NSLocalizedString("ENTER_FIRSTNAME", comment: ""), title: Key_Alert)
            return false
        }else if (txtFlds[1].text?.isEmpty)! {
            Util.showAlertWithMessage(NSLocalizedString("ENTER_LASTNAME", comment: ""), title: Key_Alert)
            return false
        }else if (txtFlds[2].text?.isEmpty)! {
            Util.showAlertWithMessage(NSLocalizedString("ENTER_EMAIL", comment: ""), title: Key_Alert)
            return false
        }else if !(txtFlds[2].text!.isValid(type: .email)) {
            Util.showAlertWithMessage(NSLocalizedString("ENTER_VALID_EMAIL", comment: ""), title: Key_Alert)
            return false
        }else if (txtFlds[3].text?.isEmpty)! {
            Util.showAlertWithMessage(NSLocalizedString("ENTER_PASS", comment: ""), title: Key_Alert)
            return false
        } else if txtFlds[3].text!.count < 8 {
            Util.showAlertWithMessage(NSLocalizedString("ENTER_8_DIGIT_PASSWORD", comment: ""), title: Key_Alert)
            return false
        }else if (txtFlds[4].text?.isEmpty)! {
            Util.showAlertWithMessage(NSLocalizedString("ENTER_ZIP", comment: ""), title: Key_Alert)
            return false
        }
        return true
    }
    
  
    
    func signUpWith() {
      //  LoaderView.kill()
       // guard AzoozRechability.isInternetAvailable else { return }
        
    }
    
    
}
