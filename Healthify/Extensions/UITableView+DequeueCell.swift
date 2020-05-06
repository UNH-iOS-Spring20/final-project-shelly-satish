//
//  SelectTypeView.swift
//
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    /// Method to dequeue for reusable table view cell method with identifier
    func dequeueCell<T: UITableViewCell>(cellType: T.Type) -> T {
        let cell = self.dequeueReusableCell(withIdentifier: String(describing: cellType)) as! T
        return cell
    }
    
    func registerCell<T: UITableViewCell>(cellType: T.Type) {
        let nib = UINib(nibName: String(describing: cellType.self), bundle: nil)
        let reuseIdentifier = String(describing: cellType.self)
        self.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    /// Method to dequeue for reusable table view header/footer method with identifier
    func dequeueHeaderFooter<T: UITableViewHeaderFooterView>(viewType: T.Type) -> T {
        let view = self.dequeueReusableHeaderFooterView(withIdentifier:  String(describing: viewType)) as! T
        return view
    }
    
    func reloadDataInMain() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func reloadTableWithAnimation(_ isEnable: Bool) {
        UIView.transition(with: self, duration: 0.4, options: .transitionCrossDissolve, animations: {
            self.reloadData()
        }, completion: nil)
    }
    
    func setEmptyView(title: String, _ textColor: UIColor? = .black, _ yAxis: CGFloat?) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.textColor = textColor == nil ? .black : textColor
           // titleLabel.font = UIFont.withType(.montserratSemiBold, size: .medium17)
            emptyView.addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: yAxis == nil ? 0 : -yAxis!).isActive = true
           // titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
            titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
            titleLabel.text = title
            titleLabel.textAlignment = .center
            // The only tricky part is here:
            self.backgroundView = emptyView
            self.separatorStyle = .none
        }
    
        func restore() {
            self.backgroundView = nil
        }
}
