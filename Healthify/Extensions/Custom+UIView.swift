//
//  SelectTypeView.swift
//
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit


extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue!.cgColor
        }
    }
    
    //    @IBInspectable var edgeInsets: UIEdgeInsets? {
    //        get {
    //            return self.edgeInsets
    //        }
    //        set {
    //            self.edgeInsets = newValue
    //        }
    //    }
    
    @IBInspectable var shadowColor: UIColor? {
        set {
            self.layer.shadowColor = newValue!.cgColor
            self.layer.masksToBounds = false;
            self.clipsToBounds = false;
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    
    
    
    /* The opacity of the shadow. Defaults to 0. Specifying a value outside the
     * [0,1] range will give undefined results. Animatable. */
    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    
    /* The shadow offset. Defaults to (0, -3). Animatable. */
    @IBInspectable var shadowOffset: CGPoint {
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
    }
    
    /* The blur radius used to create the shadow. Defaults to 3. Animatable. */
    @IBInspectable var shadowRadius: CGFloat {
        set {
            self.layer.shadowRadius = newValue
            self.layer.masksToBounds = false;
            self.clipsToBounds = false;
        }
        get {
            return layer.shadowRadius
        }
    }
    
    /** Loads instance from nib with the same name. */
    func loadNib<T: UIView>() -> T? {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? T
    }
    
    func layerWith(size: CGSize, color: UIColor, isFill : Bool) -> CALayer {
        let layer: CAShapeLayer = CAShapeLayer()
        let path: UIBezierPath = UIBezierPath()
        let lineWidth: CGFloat = 3
        path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                    radius: size.width / 2,
                    startAngle: 0,
                    endAngle: CGFloat(2 * Double.pi),
                    clockwise: false)
        layer.fillColor = isFill ? color.cgColor : nil
        layer.strokeColor = color.cgColor
        layer.lineWidth = lineWidth
        
        layer.backgroundColor = nil
        layer.path = path.cgPath
        layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        return layer
    }
    
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromLeft(duration: TimeInterval = 0.3, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    
    func slideInFromRight(duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromRightTransition = CATransition()
        
        // Customize the animation's properties
        slideInFromRightTransition.type = CATransitionType.push
        slideInFromRightTransition.subtype = CATransitionSubtype.fromRight
        slideInFromRightTransition.duration = duration
        slideInFromRightTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromRightTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromRightTransition, forKey: "slideInFromRightTransition")
    }
    
    func slideInFromBottom(duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromBottomTransition = CATransition()
        
        // Customize the animation's properties
        slideInFromBottomTransition.type = CATransitionType.push
        slideInFromBottomTransition.subtype = CATransitionSubtype.fromTop
        slideInFromBottomTransition.duration = duration
        slideInFromBottomTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromBottomTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromBottomTransition, forKey: "slideInFromBottomTransition")
    }
    
    func slideInFromTop(duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromTopTransition = CATransition()
        
        // Customize the animation's properties
        slideInFromTopTransition.type = CATransitionType.push
        slideInFromTopTransition.subtype = CATransitionSubtype.fromBottom
        slideInFromTopTransition.duration = duration
        slideInFromTopTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromTopTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromTopTransition, forKey: "slideInFromTopTransition")
    }
    
    func transformView(){
        
        self.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: ({
            self.transform = CGAffineTransform.identity
        }), completion: nil)
    }
    
    func backgroundImageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return colorImage!
    }
    
    func getSnapshotFromView() -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, UIScreen.main.scale)
        let context : CGContext = UIGraphicsGetCurrentContext()!
        self.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        self.layer.add(animation, forKey: nil)
    }
    
    func showViewWithAnimate() {
        UIView.transition(with: self, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            self.isHidden = false
        }, completion: nil)
    }
    
    
    func hideViewWithAnimate() {
        UIView.transition(with: self, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            self.isHidden = true
        }, completion: nil)
    }
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 0.8
        pulse.toValue = 1.0
        pulse.autoreverses = false
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.6
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.2
        animation.values = [-15.0, 15.0, -15.0, 15.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    func viewBottomTopAnimation(tpview: UIView){
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 8.0, options: .curveEaseInOut, animations: ({
            
            self.frame.origin.y = (tpview.frame.maxY) - self.frame.size.height
            
        }), completion: nil)
    }
    
    func viewTopBottomAnimation(tpview: UIView){
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 8.0, options: .curveEaseInOut, animations: ({
            
            self.frame.origin.y = (tpview.frame.size.height)
            
        }), completion: nil)
    }
    
    func shakeAnimation() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
        
    }
    
    func heartBeatAnimation() {
        let pulse1 = CASpringAnimation(keyPath: "transform.scale")
        pulse1.duration = 0.6
        pulse1.fromValue = 1.0
        pulse1.toValue = 1.12
        pulse1.autoreverses = true
        pulse1.repeatCount = 1
        pulse1.initialVelocity = 0.5
        pulse1.damping = 0.8
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2.7
        animationGroup.repeatCount = 1000
        animationGroup.animations = [pulse1]
        
        self.layer.add(animationGroup, forKey: "pulse")
    }
    
}

extension UIView {
    
    private func takeSnapshotOf(_ view: UIView) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: view.frame.size.width, height: view.frame.size.height))
        view.drawHierarchy(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), afterScreenUpdates: true)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
    
    func blurEffect(ofView view : UIView, withColor color : UIColor)  {
        
        let sourceImage = self.takeSnapshotOf(view)
        let inputImage = CIImage(cgImage: sourceImage.cgImage!)
        let transform = CGAffineTransform.identity
        let clampFilter = CIFilter(name: "CIAffineClamp")
        clampFilter?.setValue(inputImage, forKey: "inputImage")
        clampFilter?.setValue(NSValue(cgAffineTransform: transform), forKey: "inputTransform")
        // Apply gaussian blur filter with radius of 30
        let gaussianBlurFilter = CIFilter(name: "CIGaussianBlur")
        gaussianBlurFilter?.setValue(clampFilter?.outputImage, forKey: "inputImage")
        gaussianBlurFilter?.setValue(1.5, forKey: "inputRadius")
        
        
          let context = CIContext(options: nil)
          let cgImage = context.createCGImage(gaussianBlurFilter?.outputImage ?? CIImage(), from: inputImage.extent)
            
           //
    
            //let viewframe = self.frame.size
        //DispatchQueue.global(qos: .background).async {
            UIGraphicsBeginImageContext(self.frame.size)
            let outputContext: CGContext? = UIGraphicsGetCurrentContext()
            // Invert image coordinates
            outputContext?.scaleBy(x: 1.0, y: -1.0)
            outputContext?.translateBy(x: 0, y: -self.frame.size.height)
            // Draw base image.
            outputContext?.draw(cgImage!, in: self.frame)
            // Apply white tint
                        outputContext?.saveGState()
            //            outputContext?.setFillColor(color.cgColor)
            //            outputContext?.fill(self.frame)
                        outputContext?.restoreGState()
            // Output image is ready.
            let outputImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
     
            //DispatchQueue.main.async {
                 self.backgroundColor = UIColor(patternImage: outputImage ?? UIImage())
            //}
       // }
  
       
    }
}

