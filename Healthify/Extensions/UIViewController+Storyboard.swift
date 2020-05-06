//
//  SelectTypeView.swift
//
//  Copyright © 2020 shelly choudhary. All rights reserved.


import UIKit

extension UIViewController {


    class func popToViewController (to classType: AnyClass, navigation: UINavigationController) {
        let found = navigation.viewControllers.filter({ $0.isKind(of: classType) })
        
        if found.count > 0 {
            navigation.popToViewController(found[0], animated: true)
        }else{
            navigation.popToRootViewController(animated: true)
        }
    }
    
    var appDelegate:AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func setRootWithController(_ vc: UIViewController) {
           guard appDelegate.navigationController != nil else { return }
           appDelegate.navigationController.setViewControllers([vc], animated: true)
       }
       
       /// Method to push in navigation stack with the given view controller instance
       func pushToViewController(_ vc: UIViewController) {
           guard navigationController != nil else { return }
           navigationController?.pushViewController(vc, animated: true)
       }
       
       /// Method to push in navigation stack with the given view controller instance
       func pushToViewControllerWithoutAnimation(_ vc: UIViewController) {
           guard navigationController != nil else { return }
           navigationController?.pushViewController(vc, animated: false)
       }
       
       /// Pop to top viewcontroller from navigation stack
       func popToViewController() {
           guard navigationController != nil else { return }
           navigationController?.popViewController(animated: true)
       }
    
    func addSubview(subView:UIView, toView parentView:UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(subView)
        
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|",
                         options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|",
                         options: [], metrics: nil, views: viewBindingsDict))
    }
    
    
    func checkControllerInNavigationStack(_ VC: AnyClass)-> Bool {
            if let viewControllers = UIApplication.currentViewController()?.navigationController?.viewControllers {
                for vc in viewControllers {
                    if vc.isKind(of: VC) { return true }
                }
            }
            return false
        }
    
    @IBAction func btnBackToPopViewController(_ sender: UIButton) {
        guard navigationController?.viewControllers.count != 0 else { return }
        navigationController?.popViewController(animated: true)
    }

    
}


/// User define storyboard enum which contain storyboard name with module
enum Storyboard: String {
    
    //List down all storyboard name in cases
    case onboarding = "Onboarding"
    case dashboard = "Dashboard"
    case main       = "Main"
    
    /// return an instance of given view controller type
    func instantaite<VC: UIViewController>(_ viewControllerType: VC.Type) -> VC {
        let storyboard = UIStoryboard(name: self.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: viewControllerType.self)) as! VC
    }
    
    var  storyboard:UIStoryboard {
        return UIStoryboard(name: self.rawValue.capitalized, bundle: Bundle.main)
    }
    
    
    func viewController<T:UIViewController>(_ viewcontrollerName:T.Type) -> T {
        let idStoryboard =  (viewcontrollerName as UIViewController.Type).storyboardID
        return storyboard.instantiateViewController(identifier: idStoryboard) as! T
    }
}


extension UIViewController {
    class var storyboardID:String{
        return "\(self)"
    }
    static func instantiateFrom(_ storyboard:Storyboard) ->  Self {
        return storyboard.viewController(self)
    }
    
}

// MARK: - ▼▼▼ UIBUTTON EXT ▼▼▼
// =====================================================================
extension UIButton {
    
    func pulsateAnim() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.98
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
}

//


