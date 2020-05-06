//
//  UITextfield+Exts.swift
//  Healthify
//
//  Created by shelly choudhary on 26/03/20.
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

import Foundation


class TextField: UITextField {

    //** Set Left Pading of text field
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 30);

    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        if let lang = LoggedInUser.shared.language , lang != "" {
//            let txtFont  =  self.font
//            self.font = txtFont?.checkFontStyle(txtFont!)
//        }
        return self.newBounds(bounds)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
  
    fileprivate func newBounds(_ bounds: CGRect) -> CGRect {
        var newBounds            = bounds
        newBounds.origin.x      += padding.left
        newBounds.origin.y      += padding.top
        newBounds.size.height   -= padding.top + padding.bottom
        newBounds.size.width    -= padding.left + padding.right
        return newBounds
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if disablePaste && action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }

        return super.canPerformAction(action, withSender: sender)
    }

    // Provides left padding for images
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x += rightPadding
        return textRect
    }
    
    @IBInspectable var height : CGFloat = 40.0
    @IBInspectable var width : CGFloat = 40.0

    @IBInspectable var disablePaste: Bool = false
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateRightView()
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.lightGray
    
    func updateRightView() {
        if let image = rightImage {
            rightViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            //imageView.tintColor = color
            rightView = imageView
        } else {
            leftViewMode = .never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateLeftView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    func updateLeftView() {
        if let image = leftImage {
            leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            //imageView.tintColor = color
            leftView = imageView
        } else {
            rightViewMode = .never
            rightView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
