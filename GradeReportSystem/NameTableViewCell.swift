//
//  NameTableViewCell.swift
//  GradeReportSystem
//
//  Created by Amr Salman on 4/25/16.
//  Copyright © 2016 Amr Salman. All rights reserved.
//

import UIKit

class NameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configerCell(name: String) {
        nameLbl.text = name
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
