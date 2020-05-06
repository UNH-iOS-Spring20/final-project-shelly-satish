////
//  SelectTypeView.swift
//
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

import Foundation

class LoginVM {
    
    /// Validate Text Login Text filed data
    func isvalid(_ email: String,_ password: String) -> Bool {
        
        guard !(email.isEmpty) else {
            Util.showAlertWithMessage("ENTER_EMAIL".localizeString(), title: Key_Alert)
            return false
        }
        
        guard email.isValid(type: .email) else {
            Util.showAlertWithMessage("ENTER_VALID_NAME".localizeString(), title: Key_Alert)
            return false
        }
        
        guard !(password.isEmpty) else {
            Util.showAlertWithMessage("ENTER_PASSWORD".localizeString(), title: Key_Alert)
            return false
        }
        
        guard (password.count >= 8 && password.count <= 15) else {
            Util.showAlertWithMessage("ENTER_PASSWORD_RANGE".localizeString(), title: Key_Alert)
            return false
        }
        
        return true
    }
    
    

}
    
