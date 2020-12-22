//
//  PromoCell.swift
//  DDTest
//
//  Created by Dragos Marinescu on 12/17/20.
//

import UIKit

class PromoCell: UITableViewCell, ConfigurableCell {    
    @IBOutlet weak var line1Label: UILabel!
    @IBOutlet weak var line2Label: UILabel!
    @IBOutlet weak var line3label: UILabel!
    
    func configure(data param: String) {
        line1Label.text = "your favorite restaurant".uppercased()
        line2Label.text = "free delivery".uppercased()
        line3label.text = "above 40 chf.".uppercased()
    }
}
