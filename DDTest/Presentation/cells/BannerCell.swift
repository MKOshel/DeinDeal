//
//  BannerCell.swift
//  DDTest
//
//  Created by Dragos Marinescu on 12/17/20.
//

import UIKit


class BannerCell: UITableViewCell, ConfigurableCell  {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(data bannerModel: BannerModel) {
        titleLabel.text = bannerModel.title
        descriptionLabel.text = bannerModel.description
    }
}
