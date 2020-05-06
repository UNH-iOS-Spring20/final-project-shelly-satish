//
//  SelectTypeView.swift
//
//  Copyright © 2020 shelly choudhary. All rights reserved.
//


import Foundation
import Kingfisher

extension UIImageView {
    
    func setImage(_ imageUrl: String, placeholderImage: UIImage?, isAllowCache: Bool = false,_ isAnimate: Bool = false) {
        self.kf.indicatorType = .activity
        guard !isAnimate else {
            self.alpha = 0.3
            self.kf.setImage(with: URL.init(string: imageUrl.encodeUrl()), placeholder: placeholderImage ?? nil, options: [], progressBlock: nil) { (image, error, type, url) in
                UIView.animate(withDuration: 0.3) {
                    self.alpha = 1
                }
            }
            return
        }
        self.kf.setImage(with: URL.init(string: imageUrl.encodeUrl()), placeholder: placeholderImage ?? nil, options: isAllowCache ? [.forceRefresh] : [], progressBlock: nil) { (image, error, type, url) in
        }
    }
   
}
