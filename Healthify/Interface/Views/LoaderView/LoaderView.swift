//
//  LoaderView.swift
//

import UIKit

class LoaderView: UIView {
    
    @IBOutlet weak var imgVSpinner: UIImageView!
    
    static var LoaderView : LoaderView?
    var isStop = false
    
    class func show() {
        DispatchQueue.main.async {
            self.remove()
            LoaderView = UINib(nibName: "LoaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? LoaderView
            LoaderView!.frame = UIScreen.main.bounds
            LoaderView!.imgVSpinner.tintColor = UIColor(named: "blue")
            UIApplication.currentViewController()?.view.addSubview(LoaderView!)
            LoaderView?.isStop = false
            self.showHud()
        }
    }
    
    // MARK: Private
    private class func showHud(){
        
        LoaderView?.imgVSpinner.transform = CGAffineTransform(scaleX: 0, y: 0)
        LoaderView?.rotateSpinner()
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.curveEaseOut], animations: {
            LoaderView?.imgVSpinner.transform = CGAffineTransform(scaleX: 1, y: 1)
            //LoaderView?.backgroundColor = Color.rgba(0, 0, 0, 0.5)
        }, completion: nil)
    }
    
    private func rotateSpinner() {
        let rotationAnimation =  CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = CGFloat.pi * 2.0
        rotationAnimation.duration = 0.8
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = HUGE
        imgVSpinner.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    private class func remove(){
        if LoaderView != nil {
            LoaderView!.imgVSpinner.layer.removeAllAnimations()
            LoaderView!.removeFromSuperview()
            LoaderView = nil
        }
    }
    
    class func kill(){
        DispatchQueue.main.async {
            if LoaderView != nil {
                UIView.transition(with: LoaderView?.imgVSpinner ?? UIView() , duration: 0.45, options: .transitionCrossDissolve, animations: {
                    self.remove()
                }, completion: nil)
            }
        }
    }
}

