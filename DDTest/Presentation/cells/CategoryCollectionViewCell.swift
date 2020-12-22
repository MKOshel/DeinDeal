//
//  CategoryCollectionViewCell.swift
//  DDTest
//
//  Created by Dragos Marinescu on 12/18/20.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @UsesAutoLayout private var container: UIView!
    @UsesAutoLayout private var foodImageView: UIImageView!
    @UsesAutoLayout private var titleLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                foodImageView.backgroundColor = .red
                titleLabel.textColor = .red
            } else {
                foodImageView.backgroundColor = .white
                titleLabel.textColor = .black
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
   func configure(with item: FoodCategory) {
        titleLabel.text = item.label
        let imageURL = URL(string: item.icon.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    
        foodImageView.sd_setImage(with: imageURL,
                                  placeholderImage: UIImage(named: "cart_gray"),
                                  options: [], completed: nil)
    }
    
    private func setup() {
        createComponents()
        addConstraints()
    }
    
    private func createComponents() {
        container = UIView(frame: .zero)
        
        foodImageView = UIImageView(frame: .zero)
        foodImageView.contentMode = .scaleAspectFit
        foodImageView.clipsToBounds = false
        foodImageView.layer.cornerRadius = 15
        
        titleLabel = UILabel(frame: .zero)
        titleLabel.font = UIFont(name: "AvenirNext", size: 8)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        titleLabel.minimumScaleFactor  = 0.5
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = titleLabel.font.withSize(12)
        
        contentView.addSubview(container)
        container.addSubview(foodImageView)
        container.addSubview(titleLabel)
        
    }
    
    private func addConstraints() {
        container.fixInView(contentView)

        foodImageView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        foodImageView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        foodImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        foodImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true

        titleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: 8).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
    }
}
