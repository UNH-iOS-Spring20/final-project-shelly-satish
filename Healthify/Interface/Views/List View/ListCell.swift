//
//  SelectTypeView.swift
//
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblCodeWidth_Constr: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUpData(selectTypeList: ListDetail) {
        lblName.text = selectTypeList.name
        imgView.tintColor = selectTypeList.isSelected ? #colorLiteral(red: 0, green: 0.5812222362, blue: 0.9731387496, alpha: 1) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        if selectTypeList.code == nil || selectTypeList.code == "" {
            lblCodeWidth_Constr.constant = 0
        }else {
            lblCodeWidth_Constr.constant = 70
            lblCode.text = selectTypeList.code
        }
       
    } 
}
