//
//  SelectTypeView.swift
//
//  Copyright © 2020 shelly choudhary. All rights reserved.
//
import Foundation

enum RegexType {
    case email
    case upperCase
    case lowerCase
    case fullName
    case phone
    case zipCode
    case password
    case birthDay
    case numbers
    
    func getRegex() -> String {
        switch self {
        case .fullName:
            //            return "[a-zA-Z ]{1,20}"
            return "[a-zA-Z ]+"   //Alternate
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case .upperCase:
            //            return "[A-Z ]{1,50}"
            return "[A-Z ]+"
        case .lowerCase:
            //            return "[a-z ]{1,50}"
            return "[a-z ]+"  //Alternate
        case .phone :
            return "^[0-9]{4,15}$" //"[0-9]{3}+-[0-9]{3}+-[0-9]{4}"
        case .zipCode:
            return "[0-9]{6}"
        case .password:
            return "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,16}"
        case .birthDay:
            //            return "[0-9]{2}/[0-9]{2}/[0-9]{4}"
            return "[\\d]{2}(/|-|.)[\\d]{2}(/|-|.)[\\d]{4}"    //Alternate
        case .numbers:
            return"^[0-9 ]+"
        }
    }
}

extension String {
    func isValid(type: RegexType) -> Bool {
        let regex = type.getRegex()
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
}

