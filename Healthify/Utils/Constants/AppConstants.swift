//
//  AppConstants.swift
//  HealthyApp
//
//  Created by shelly choudhary on 25/03/20.
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

import Foundation
import UIKit


/// Return App Delegate Instance
var appDelegate:AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}

/// Return App Bundle Identifier
var kBundleIdentifier = {
    return Bundle.main.bundleIdentifier
}

/// Return App is in english
var isEnglishLang: Bool {
    return appShortLanguageName == "en-US"
}

/// Return UserDefaults Instance
var userDefault: UserDefaults {
    return UserDefaults.standard
}


/// Return App Language in shot form
var appShortLanguageName: String {
    return (Locale.current.languageCode ?? "en") == "pt" ? "pt-BR" : "en-US"
}

/// Return App Language
var appLanguage: String {
    //pt-PT
    return (Locale.current.languageCode ?? "en") == "pt" ? "pt-BR" : "en-US"
    //"en-US"
}

//************************** Constants for FIREBASE NODE **************************//
let kFitnessRegime              = "user_fitness_regime"
let kUsers                      = "users"

//MARK: FIREBASECLOUDSTORE
let kUserFitnessRegime                        = "kUserFitnessRegime"

// LANGUAGE CONSTANTS
let kSpanishLang                = "SPANISH"
let kEnglishLang                = "ENGLISH"
let kLanguageCellIdentifier     =  "languageTbleCellIdentifier"
let kAppleLanguages        = "AppleLanguages"
// ===========================================


//************************** Constants for Alert messages **************************//
let Key_Alert                        = "ALERT".localizeString()
let Key_Message                      =  "MESSAGE".localizeString()
let Msg_Sorry                         = "SOMTHING_WRONG_ALERT".localizeString()
let Msg_TimeOut                       = "REQUEST_TIMED_OUT_ALERT".localizeString()
let Msg_CheckConnection               = "CHECK_CONNECTION_ALERT".localizeString()
let Msg_ConnectionLost                = "NETWORK_LOST_ALERT".localizeString()
let Msg_DescriptionLimit              = "DESCRIPTION_LIMIT_ALERT".localizeString()
let Msg_Tags                          = "TAGS_BLANK_ALERT".localizeString()
let Msg_AddImage                      = "IMAGE_BLANK_ALERT".localizeString()



//MARK: Login or Signup
let kPassword        = "password"
let kPhoneNumber     = "phone_number"
let kMobileNumber     = "mobile_number"
let kUserRole        = "user_role"
let kCode            = "code"
let kfirstName            = "fsname"
let klastName            = "lsname"
let kEmail           = "emailId"
let kImage           = "image"
let kIsoCode         = "ifso_code"
let kLanguage        = "language"
let kCountry            = "country"


//MARK: Common
let ApiData                          = "data"
let ApiDeviceToken                   = "device_id"
let ApiDeviceType                    = "device_type"
let ApiCertificationType             = "certification_type"
let DeviceToken                      = "device_token"
let UserRegistered                   = "UserRegistered"
let UserLoggedIn                     = "UserLoggedIn"
let DocumentStore                  =  "DocumentStoreCreated"



