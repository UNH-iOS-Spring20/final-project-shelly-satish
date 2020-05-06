//
//  LoggedInUser.swift
//  Healthify
//
//  Created by shelly choudhary on 26/03/20.
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

import Foundation


class LoggedInUser {
    
    fileprivate var storage:UICKeyChainStore = UICKeyChainStore.init(service: Bundle.main.bundleIdentifier!)
    
    private  init() {}
    static var shared: LoggedInUser = LoggedInUser()
    
    var firstName: String = ""
    var lastName: String = ""
    var emailId: String = ""
    var zipCode: String = ""
    var country: String = ""
    var uid: String = ""
    var isLoggedIn: Bool = false
    var isFStoreDocumenCreated: Bool =  false
    var userFitnessRegime: FitnessRegime? 
    
    func synKeyChain() {
        
        storage.setString(uid, forKey: "UID")
        storage.setString(emailId, forKey: kEmail)
        storage.setString(firstName, forKey: kfirstName)
        storage.setString(lastName, forKey: klastName)
        storage.setString(country, forKey: kCountry)
        storage.setString(zipCode, forKey: kIsoCode)
        self.upadteUserDefaults()
    }
    
    func upadteUserDefaults() {
        UserDefaults.standard.set(isFStoreDocumenCreated, forKey: DocumentStore)
        UserDefaults.standard.set(true, forKey: UserLoggedIn)
        UserDefaults.standard.synchronize()
    }
    
    func updateLoggedInUser(dict: NSDictionary) {
        LoggedInUser.shared.firstName = dict["firstName"] as? String ?? ""
        LoggedInUser.shared.lastName = dict["lastName"] as? String ?? ""
        LoggedInUser.shared.emailId = dict["eamilId"] as? String ?? ""
        LoggedInUser.shared.zipCode = dict["zipCode"] as? String ?? ""
        LoggedInUser.shared.country = dict["country"] as? String ?? ""
        if let fitRegime = dict["user_fitness_regime"] as? NSDictionary {
            LoggedInUser.shared.userFitnessRegime =  FitnessRegime(dict: fitRegime)
        }
        LoggedInUser.shared.uid = Auth.auth().currentUser!.uid
        LoggedInUser.shared.isLoggedIn = true
        LoggedInUser.shared.synKeyChain()
    }
    
    var isFStoreCreated: Bool {
        set{
            self.isFStoreDocumenCreated = newValue
            self.upadteUserDefaults()
        }get{
            return self.isFStoreDocumenCreated
        }
    }
    
    func retrieveDataFromFireBase(callBack: @escaping (Bool) -> ()) {
        
        guard let userAuth =  Auth.auth().currentUser else {
            callBack(false)
            return
        }
        
        appDelegate.dbRef?.child(kUsers).child(userAuth.uid).observeSingleEvent(of: .value, with: { (snpshot) in
            if snpshot.exists() {
                let dict = (snpshot.value as! NSDictionary)
                self.updateLoggedInUser(dict: dict)
                callBack(true)
            }
        })
        
    }
    
    
    func retrieveDetails() {
        
        emailId             = storage.string(forKey: kEmail) ?? ""
        //id                = storage.string(forKey: kId)
        firstName              = storage.string(forKey: kfirstName) ?? ""
        lastName              = storage.string(forKey: klastName) ?? ""
        zipCode               = storage.string(forKey: kIsoCode) ?? ""
        uid               = storage.string(forKey: "UID") ?? ""
    }
    
    func clear() -> Void {
        
        firstName = ""
        lastName = ""
        emailId = ""
        zipCode = ""
        country = ""
        uid =  ""
        
        UserDefaults.standard.removeObject(forKey: UserLoggedIn)
        UserDefaults.standard.removeObject(forKey: UserRegistered)
        UserDefaults.standard.removeObject(forKey: DocumentStore)
        UICKeyChainStore.removeAllItems(forService: Bundle.main.bundleIdentifier!)
    }
    
    func logoutUser() {
        Util.showAlertWithMessage("USER_LOGOUT_PERMISSION".localizeString(), title: Key_Alert.localizeString(), cancelBtn: "CANCEL".localizeString(), okBtn: "OK".localizeString()) { (index) in
            if index == 2 {
                do {
                    try Auth.auth().signOut()
                    LoggedInUser.shared.clear()
                    appDelegate.navigationController.setViewControllers([Storyboard.onboarding.instantaite(LoginVC.self)], animated: true)
                }catch {
                    print("Not Able to logout")
                }
            }
        }
        
        
    }
}

