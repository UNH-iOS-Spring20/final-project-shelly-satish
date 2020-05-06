//
//  Util.swift


import Foundation
import UIKit
import Photos
import MessageUI
import MapKit


public typealias HTTPParameters = [String: Any]

class Util : NSObject {

    static var deviceToken: String? {
        willSet {
            self.deviceToken = newValue
        }
    }
    
    
    static var documentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.endIndex - 1]
    }()
    
    static var cacheDirectory: URL = {
        let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return urls[urls.endIndex - 1]
    }()
    
    static func isFileExist(_ fileName : String) -> Bool {
        
        let path = Util.documentsDirectory.appendingPathComponent(fileName)
        let fileManager = FileManager.default
        return fileManager.fileExists(atPath: path.absoluteString)
    }
    
    // MARK: - *******Validations Methods*******
    class func isValidEmail(_ emailStr: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailStr)
    }
    
    //MARK: ***** DATE PICKER *****
    
    
    class func datePickerForTxtField(_ sender: UITextField) -> UIDatePicker{
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let currentDate: Date = Date()
        let components: NSDateComponents = NSDateComponents()
        components.year = -150
        
        var dateComponent = DateComponents()
        let yearsToSubtract = -6
        dateComponent.year = yearsToSubtract
        let dateFromCurrent = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        let minDate: Date = gregorian.date(byAdding: components as DateComponents, to: dateFromCurrent ?? currentDate, options: NSCalendar.Options(rawValue: 0))!
        
        datePickerView.minimumDate = minDate
        datePickerView.maximumDate = dateFromCurrent
        sender.inputView = datePickerView
        return datePickerView
    }
    
    class func jsonString(_ object: Any) -> String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted])
            return String(data: data, encoding: .utf8)
        } catch {
            return nil
        }
    }

    class func jsonSerialize(_ data: Data) -> HTTPParameters? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? HTTPParameters
            return json
        } catch {
            return nil
        }
    }
    
    class func isValidPassword(_ passStr: String) -> Bool {
        
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9]).{8,16}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: passStr)
    }
    
    class func getValidString(_ string: String?) -> (String) {
        
        if string == nil || string!.isKind(of: NSNull.self) || string == "null" || string == "<null>" || string == "(null)" {
            
            return ""
        }
        return string!.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    class func isValidString(_ string: String) -> (Bool) {
        
        let str = getValidString(string)
        return !str.isEmpty
    }
    
    class func removeInLineWhiteSpace(_ string: String) -> (String) {
        
        return string.replacingOccurrences(of: " ", with: "")
    }
    
    class func encodedURL(_ string: String) -> (String) {
        
        return string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
    
  
    class func extractYoutubeIdFromLink(link: String) -> String? {
        
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        guard let regExp = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return nil
        }
        let nsLink = link as NSString
        let options = NSRegularExpression.MatchingOptions(rawValue: 0)
        let range = NSRange(location: 0, length: nsLink.length)
        let matches = regExp.matches(in: link as String, options:options, range:range)
        if let firstMatch = matches.first {
            return nsLink.substring(with: firstMatch.range)
        }
        return nil
    }
    
    // MARK: - Plist
    // Get Data From Plist
    
    
    
    class func getJsonData(_ name: String) -> [[String : String]] {
        
        if let path = Bundle.main.path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: String]]
                return json
            } catch let error {
                print(error.localizedDescription)
            }
        } else { print("Invalid filename/path.")  }
        
        return []
    }
    
    
    class func getPlistData(_ name: String) -> [String: Any]{
        let path = Bundle.main.path(forResource: name, ofType: "plist")
        return NSDictionary(contentsOfFile: path!) as! [String : Any]
    }
    
    
    // MARK: - ********Attachment Image Icon Into String*********
    class func getAttributedStringWithIconName(iconName:String, text:String, isFront:Bool, offset:CGFloat) ->  NSMutableAttributedString {
        
        if let image = UIImage(named: iconName) {
            let attachment = NSTextAttachment()
            attachment.image = image
            
            let offsetY = offset
            attachment.bounds = CGRect(x: 0, y: offsetY, width: (attachment.image?.size.width)!, height: (attachment.image?.size.height)!)
            
            let attachmentString = NSAttributedString(attachment: attachment)
            
            if isFront {
                let attachment1 = NSMutableAttributedString(attributedString: attachmentString)
                let textString  = NSMutableAttributedString(string: text)
                attachment1.append(textString)
                
                return attachment1
                
            }else {
                let textString  = NSMutableAttributedString(string: text)
                textString.append(attachmentString)
                return textString
            }
        }else{
            let textString  = NSMutableAttributedString(string: text)
            return textString
        }
    }
    
    
    // MARK: - ******* Add new Constraints to its superview ********
    class func addConstraints(toView : UIView, constraints : (CGFloat,CGFloat,CGFloat,CGFloat) ){
        
        DispatchQueue.main.async {

            var allConstraints = [NSLayoutConstraint]()
            
            let views = ["toView" : toView]
            
            let hFormate = "H:|-[toView]-|"
            let hCostraints = NSLayoutConstraint.constraints(withVisualFormat: hFormate, options: [], metrics: nil, views: views)
            allConstraints += hCostraints
            
            let vFormate = "V:|-[toView]-|"
            let vCostraints = NSLayoutConstraint.constraints(withVisualFormat: vFormate, options: [], metrics: nil, views: views)
            allConstraints += vCostraints
            
            NSLayoutConstraint.activate(allConstraints)
        }
    }
    
    // MARK: - *******Alert Methods*******
    class func showNetWorkAlert() {
        
        showAlertWithMessage(NSLocalizedString("CHECK_CONNECTION_ALERT", comment: ""), title:NSLocalizedString("NO_NETWORK_ALERT", comment: ""))
    }
    
    
    class func showAlertWithMessage(_ message: String, title: String, handler:(()->())? = nil)
    {
        DispatchQueue.main.async {
            //** If any Alert view is alrady presented then do not show another alert
            var viewController : UIViewController!
            if let vc  = UIApplication.currentViewController() {
                if (vc.isKind(of: UIAlertController.self)) {
                    return
                }else{
                    viewController = vc
                }
            }else{
                viewController = appDelegate.window?.rootViewController!
            }

            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           // alert.fonts(message: message, title: title)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: { (_) in
                handler?()
            }))
            viewController!.present(alert, animated: true, completion: nil)
            
        }
    }
    
    class func showAlertWithMessage(_ message: String, title: String, cancelBtn: String, okBtn: String, handler: @escaping(Int) -> Void) {
        
        DispatchQueue.main.async {

            // ** If any Alert view is already presented then do not show another alert
            var viewController : UIViewController!
            if let vc  = UIApplication.currentViewController() {
                if (vc.isKind(of: UIAlertController.self)) {
                    return
                }else{
                    viewController = vc
                }
            }else{
                viewController = appDelegate.window?.rootViewController!
            }
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            alert.title = title
            alert.message = message
          //  alert.fonts(message: message, title: title)
            if cancelBtn != ""{
                alert.addAction(UIAlertAction(title: cancelBtn, style: .default, handler: { (action) in
                    handler(1)
                }))
            }
            if okBtn != "" {
                alert.addAction(UIAlertAction(title: okBtn, style: .default, handler: { (action) in
                    handler(2)
                }))
            }
            viewController!.present(alert, animated: true, completion: nil)
        }
    }
    
    class func showLocationServicesDisabledAlert() -> Void {
        
        DispatchQueue.main.async {
            showAlertWithMessage("ALLOW_LOCATION_ALERT".localizeString(), title: "ALLOW_LOCATION_ALERT_TITLE".localizeString(), handler: {
                let settingsUrl = URL(string: UIApplication.openSettingsURLString)
                UIApplication.shared.open(settingsUrl!, options: [:], completionHandler: nil)
            })
        }
    }
    
    //MARK: - ********Image Picker********
    
    class func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = UIApplication.currentViewController() as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.allowsEditing = true
        
        let alert = UIAlertController(title: NSLocalizedString("CHOOSE_IMAGE", comment: ""), message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: NSLocalizedString("CAMERA", comment: ""), style: .default, handler: { _ in
            Util.openCamera(imagePicker)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("GALLERY", comment: ""), style: .default, handler: { _ in
            Util.openGallary(imagePicker)
        }))
        alert.addAction(UIAlertAction.init(title: NSLocalizedString("CANCEL", comment: ""), style: .cancel, handler: nil))
        UIApplication.currentViewController()?.present(alert, animated: true, completion: nil)
    }
    
   
    
    class func openCamera(_ picker: UIImagePickerController){
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            picker.sourceType = UIImagePickerController.SourceType.camera
            picker.allowsEditing = true
            UIApplication.currentViewController()?.present(picker, animated: true, completion: nil)
            
        } else {
            let alert  = UIAlertController(title: NSLocalizedString("WARNING", comment: ""), message: NSLocalizedString("NO_CAMERA_ALERT", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            UIApplication.currentViewController()?.present(alert, animated: true, completion: nil)
        }
    }
    
    class func openGallary(_ picker: UIImagePickerController){
        
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.allowsEditing = true
        UIApplication.currentViewController()?.present(picker, animated: true, completion: nil)
    }
    
    class func openUrl(_ url: String){
        UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
    }
    
    
    class func dateFormatTime12(serverDate: String, format: DateFormat) -> String {
        let formatter1 = DateFormatter()
        let date = Date.dateFromString(serverDate, format: format)
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "dd/MM/yyyy hh:mm a"
        formatter2.amSymbol = "am"
        formatter1.pmSymbol = "pm"
        return formatter2.string(from: date!)
    }
    
    class func getCountryNameFromCode(_ code: String) -> String {
        let countries =  Util.getJsonData("countryCodes")
        return countries.filter({ $0["code"]?.lowercased()  == code.lowercased() }).first?["name"] ?? ""
        
        //return countries.filter({ $0["code"]?.lowercased()  == code.lowercased() }).first?["name"] ?? "Kuwait"
    }
    
    
       
}

extension CLLocation {
    
    func isValid() -> Bool {
        let locationAge = -timestamp.timeIntervalSinceNow
        return (horizontalAccuracy > 0 && locationAge < 5)
    }
}


enum DateFormat {
    case onlyDate, onlyTime, onlyDate1, onlyDate2, onlyDate3, onlyTime12,dayFormat ,onlyTime24, full, full1, full2, onlyDateShort, onlyMonthShort, onlyWeekDay, fullDateTimeZone, dayTimeFormat, onlyDate6
}

extension Double {
    func threeDecimal() -> String {
        return String(format: "%0.3f", self)
    }
    
    func twoDoubleDecimal() -> Double {
        return Double(String(format: "%0.3f", self)) ?? 0
    }
    
    func removeDecimal() -> String {
        return String(format: "%f", self)
    }
}

extension Float {
    func threeDecimal() -> String {
        return String(format: "%0.2f", self)
    }
}


extension Date {
    
    func isBetweeen(date date1: Date, andDate date2: Date) -> Bool {
        return date1.compare(self) == self.compare(date2)
    }
    
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
      // guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 0, to: Date())
    }
    
    
    func dateAt(hours: Int, minutes: Int) -> Date
        {
            let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
            
            //get the month/day/year componentsfor today's date.
            
            
            var date_components = calendar.components(
                [NSCalendar.Unit.year,
                 NSCalendar.Unit.month,
                 NSCalendar.Unit.day],
                from: self)
            
            //Create an NSDate for the specified time today.
            date_components.hour = hours
            date_components.minute = minutes
            date_components.second = 0
            
            let newDate = calendar.date(from: date_components)!
            return newDate
        }
    
    
    static func getTimeIn12HrsFormate(_ strTime: String) -> String {
        let dateAsString = strTime
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let date = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "h:mm a"
        let Date12 = dateFormatter.string(from: date!)
        return Date12
    }
    
    
    static func stringFromDate(_ date:Date, format:DateFormat) -> String {
        
        var dateFormatter:DateFormatter {
            
            switch format {
            case .onlyDate:
                return DateFormatter.dateFormatterOnlyDate
            case .onlyDate6:
                return DateFormatter.dateFormatterOnlyDate6
            case .onlyTime:
                return DateFormatter.dateFormatterOnlyTime
            case .onlyDate1:
                return DateFormatter.dateFormatterOnlyDate1
            case .dayFormat:
                return DateFormatter.dayFormatter
            case .onlyDate2:
                return DateFormatter.dateFormatterOnlyDate2
            case .onlyDate3:
                return DateFormatter.dateFormatterOnlyDate3
            case .onlyTime12:
                return DateFormatter.dateFormatterOnlyTime12
            case .onlyTime24:
                return DateFormatter.dateFormatterOnlyTime24
            case .full:
                return DateFormatter.dateFormatterFullDate
            case .full1:
                return DateFormatter.dateFormatterFullDate1
            case .full2:
                return DateFormatter.dateFormatterFullDate2
            case .onlyDateShort:
                return DateFormatter.dateFormatterOnlyDateShort
            case .onlyMonthShort:
                return DateFormatter.dateFormatterOnlyMonthShort
            case .onlyWeekDay:
                return DateFormatter.dateFormatterOnlyWeekDay
            case .fullDateTimeZone:
                return DateFormatter.dateFormatterFullDateWithTimeZone
            case .dayTimeFormat:
                return DateFormatter.dateFormatterFullDateTime
            }
        }
//        if format == .dayFormat {
//            if deviceLang == "ar" {
//                dateFormatter.locale = NSLocale(localeIdentifier: "ar") as Locale
//            }else {
//                dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale
//            }
//        }
        return dateFormatter.string(from: date).lowercased()
    }
    
    static func dateFromString(_ date:String, format:DateFormat) -> Date? {
        
        var dateFormatter:DateFormatter {
            
            switch format {
            case .onlyDate:
                return DateFormatter.dateFormatterOnlyDate
            case .onlyDate6:
                return DateFormatter.dateFormatterOnlyDate6
            case .onlyTime:
                return DateFormatter.dateFormatterOnlyTime
            case .onlyDate1:
                return DateFormatter.dateFormatterOnlyDate1
            case .dayFormat:
                return DateFormatter.dayFormatter
            case .dayTimeFormat:
                return DateFormatter.dateFormatterFullDateTime
            case .onlyDate2:
                return DateFormatter.dateFormatterOnlyDate2
            case .onlyDate3:
                return DateFormatter.dateFormatterOnlyDate3
            case .onlyTime12:
                return DateFormatter.dateFormatterOnlyTime12
            case .onlyTime24:
                return DateFormatter.dateFormatterOnlyTime24
            case .full:
                return DateFormatter.dateFormatterFullDate
            case .full1:
                return DateFormatter.dateFormatterFullDate1
            case .full2:
                return DateFormatter.dateFormatterFullDate2
            case .onlyDateShort:
                return DateFormatter.dateFormatterOnlyDateShort
            case .onlyMonthShort:
                return DateFormatter.dateFormatterOnlyMonthShort
            case .onlyWeekDay:
                return DateFormatter.dateFormatterOnlyWeekDay
            case .fullDateTimeZone:
                return DateFormatter.dateFormatterFullDateWithTimeZone
            }
        }

        
        return dateFormatter.date(from: date)
    }
    
    static func getCurrentYearLastTwoDigit() -> Int {
        let date = Date()
        let calendar = Calendar.current
        
        return calendar.component(.year, from: date) % 100
    }
    
   static func dateFormatted(_ dateStr: String) -> String? {
        guard dateStr != "" else {
            return nil
        }
        let frmtedDate = Date.dateFromString(dateStr, format: .full)
        return Date.stringFromDate(frmtedDate!, format: .dayTimeFormat)
    }
}




extension DateFormatter {
    
    @nonobjc static let dateFormatterFullDateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "dd/MM/yyyy hh:mm a"
        formatter.timeZone = TimeZone.current
        
        return formatter
    }()
    
    @nonobjc static let dateFormatterOnlyDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone
        formatter.timeZone = TimeZone.current
        
        return formatter
    }()
    
    @nonobjc static let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM, E"
        formatter.timeZone = TimeZone.current
        
        return formatter
    }()
    
    
    @nonobjc static let dateFormatterOnlyDate1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "dd/MMM/yyyy"
        formatter.timeZone = TimeZone.current
        
        return formatter
    }()
    
    @nonobjc static let dateFormatterOnlyDate2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone.current
        
        return formatter
    }()
    
    @nonobjc static let dateFormatterOnlyDate3: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.timeZone = TimeZone.current
        
        return formatter
    }()
    
    @nonobjc static let dateFormatterOnlyDate6: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.timeZone = TimeZone.current
        
        return formatter
    }()
    
    
    @nonobjc static let dateFormatterOnlyTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.timeZone = TimeZone.current
        return formatter
    }()
    
    @nonobjc static let dateFormatterOnlyTime12: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        //formatter.timeZone = TimeZone.current
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter
    }()
    
    @nonobjc static let dateFormatterOnlyTime24: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    @nonobjc static let dateFormatterFullDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //formatter.timeZone = TimeZone.current
        return formatter
    }()

  
    
    @nonobjc static let dateFormatterFullDate1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy h:mm a"
        formatter.timeZone = TimeZone.current
        return formatter
    }()

    @nonobjc static let dateFormatterFullDate2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a, dd MMM, yyyy"
        formatter.timeZone = TimeZone.current
        return formatter
    }()
    
    @nonobjc static let dateFormatterOnlyDateShort: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        formatter.timeZone = TimeZone.current
        return formatter
    }()
    
    @nonobjc static let dateFormatterOnlyMonthShort: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        formatter.timeZone = TimeZone.current
        return formatter
    }()
    
    @nonobjc static let dateFormatterOnlyWeekDay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.timeZone = TimeZone.current
        return formatter
    }()
    
    @nonobjc static let dateFormatterFullDateWithTimeZone: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()

}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}


