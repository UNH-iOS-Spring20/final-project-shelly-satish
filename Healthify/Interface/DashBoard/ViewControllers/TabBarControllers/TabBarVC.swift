//
//  TabBarVC.swift
//  HealthyApp
//
//  Created by shelly choudhary on 25/03/20.
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

import UIKit


class TabBarVC: UITabBarController {
    
    // MARK: - ▼▼▼ Properties ▼▼▼
    var moreButton: ExpandingMenuButton!

    
    // MARK: - ▼▼▼ IBOUTLET Properties ▼▼▼

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIConfig()
    }
    
    private func setupUIConfig() {
        
        UITabBar.appearance().barTintColor = .black
        UITabBar.appearance().tintColor = #colorLiteral(red: 0, green: 0.5812222362, blue: 0.9731387496, alpha: 1)
        self.tabBar.items![0].title = "HOME".localizeString()
        self.tabBar.items![1].title = "CHAT".localizeString()
        self.tabBar.items![2].title = "ME".localizeString()
        self.tabBar.items![3].title = "MORE".localizeString()
        configureExpandingMenuBtns()
    }
    
    
    private func configureExpandingMenuBtns() {
        
        let tabHeight = self.tabBar.bounds.size.height
        let tabWidth = self.tabBar.bounds.size.width/4
        var bottomInset : CGFloat = 0.0
        if #available(iOS 11.0, *) {
            bottomInset = (UIApplication.shared.keyWindow?.safeAreaInsets.bottom)!
        }
        let moreButtonSize: CGSize = CGSize(width: tabWidth, height: tabHeight)
        let viewY = view.bounds.height - tabHeight - bottomInset
        
        moreButton = ExpandingMenuButton(frame: CGRect(x: view.bounds.width - tabWidth, y: viewY, width: tabWidth, height: tabHeight), image: UIImage(systemName: "ellipsis")!, rotatedImage: UIImage(systemName: "ellipsis")!)
               view.insertSubview(moreButton, aboveSubview: self.tabBar)
        moreButton.tintColor = .gray
               self.view.addSubview(moreButton)
               view.layoutIfNeeded()
        
        let item1 = ExpandingMenuItem(size: moreButtonSize, title: "SETTINGS".localizeString(), image: UIImage(systemName: "slowmo")!, highlightedImage: UIImage(systemName: "slowmo")!, backgroundImage: UIImage(systemName: "slowmo"), backgroundHighlightedImage: UIImage(systemName: "slowmo")) { () -> Void in
            //showAlert("Profile")
        }
        
        let item2 = ExpandingMenuItem(size: moreButtonSize, title: "SIGNOUT".localizeString(), image: UIImage(systemName: "power")!, highlightedImage: UIImage(systemName: "power")!, backgroundImage: UIImage(systemName: "power"), backgroundHighlightedImage: UIImage(systemName: "power")) { () -> Void in
            //showAlert("Settings")
            LoggedInUser.shared.logoutUser()
        }
        moreButton.addMenuItems([item1, item2])
        
        moreButton.willPresentMenuItems = { (menu) -> Void in
            self.moreButton.tintColor = #colorLiteral(red: 0, green: 0.4779999852, blue: 1, alpha: 0.9597821303)
            print("MenuItems will present.")
        }
        
        moreButton.didDismissMenuItems = { (menu) -> Void in
            self.moreButton.tintColor = .gray
            print("MenuItems dismissed.")
        }
    }
    
}


