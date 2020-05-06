//
//  LanguageTbleCell.swift
//  HealthyApp
//
//  Created by shelly choudhary on 25/03/20.
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

import UIKit

class LanguageTbleCell: UITableViewCell {
    
    @IBOutlet weak var lblLangName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupCell(data: String) {
        self.lblLangName.text = data
    }

}
