//
//  PhoneTableViewCell.swift
//  Riot
//
//  Created by Naurin Afrin on 5/8/20.
//  Copyright © 2020 matrix.org. All rights reserved.
//

import UIKit

class PhoneTableViewCell: UITableViewCell {

    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var value: UILabel!
    
    func setNumber(number: String) {
        value.text = number
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ThemeService.shared().theme.recursiveApply(on: self.contentView)
        heading.text = AlternateHomeTools.getNSLocalized("phone", in: "Vector")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
