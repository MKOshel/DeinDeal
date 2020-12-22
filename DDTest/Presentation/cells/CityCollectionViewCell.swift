//
//  CityCollectionViewCell.swift
//  DDTest
//
//  Created by Dragos Marinescu on 12/17/20.
//

import UIKit
import SDWebImage

class CityCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 15
    }
    
    func configure(with city: City) {
        titleLabel.text = city.channelInfo.title.uppercased()
        let url = URL(string: city.channelInfo.images.large)
        imageView.sd_setImage(with: url, completed: nil)
    }
    
}
