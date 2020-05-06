//
//  SelectTypeView.swift
//
//  Copyright © 2020 shelly choudhary. All rights reserved.
//


import Foundation
import UIKit

extension String {
    
    func encodeUrl() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
    
    /// Convert String in localize form
    func localizeString() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func setAttributedStringWithColor(toString: String , color : UIColor)->  NSMutableAttributedString {
        let range = (self as NSString).range(of: toString)
        let attributedString = NSMutableAttributedString(string:self)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        return attributedString
    }
    
}

extension Notification.Name {
    static let offerNotification = Notification.Name(rawValue: "OfferNotification")
    static let trackOrder = Notification.Name(rawValue: "TrackOrder")
    static let orderDetails = Notification.Name(rawValue: "OrderDetails")
}


extension String {
    
    func type() -> String {
        
        switch self {
        case kEnglishLang.localizeString():
            return "en"
        case  kSpanishLang.localizeString():
            return "es"
        default:
            return "en"
        }
        
    }
    
    
}
