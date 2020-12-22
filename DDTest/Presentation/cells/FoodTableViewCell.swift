//
//  FoodTableViewCell.swift
//  DDTest
//
//  Created by Dragos Marinescu on 12/18/20.
//

import UIKit

class FoodTableViewCell: UITableViewCell, ConfigurableCell {
    @UsesAutoLayout private var container: UIView!
    @UsesAutoLayout private var labelStackView: UIStackView!
    @UsesAutoLayout private var foodImageView: UIImageView!
    @UsesAutoLayout private var titleLabel: UILabel!
    @UsesAutoLayout private var subtitleLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
   func configure(data item: FoodItem) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    
        let imageURL = URL(string: item.images.cover.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        foodImageView.sd_setImage(with: imageURL,
                                  placeholderImage: UIImage(named: "placeholder"),
                                  options: [],
                                  context: nil)
    }
    
    private func setup() {
        createComponents()
        addConstraints()
    }
    
    private func createComponents() {
        container = UIView(frame: .zero)
        foodImageView = UIImageView(frame: .zero)
        foodImageView.contentMode = .scaleAspectFit
        foodImageView.clipsToBounds = true
        
        titleLabel = UILabel(frame: .zero)
        titleLabel.font = UIFont(name: "AvenirNext-Bold", size: 12)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        
        subtitleLabel = UILabel(frame: .zero)
        subtitleLabel.font = UIFont(name: "AvenirNext", size: 12)
        subtitleLabel.textColor = .black
        subtitleLabel.numberOfLines = 1
        
        labelStackView = UIStackView(frame: .zero)
        labelStackView.axis = .vertical
        labelStackView.alignment = .leading
        labelStackView.distribution = .fillProportionally
        labelStackView.spacing = 0
        
        contentView.addSubview(container)
        container.addSubview(foodImageView)
        container.addSubview(labelStackView)
        
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(subtitleLabel)
        
    }
    
    private func addConstraints() {
        container.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        foodImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: -50).isActive = true
        foodImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        foodImageView.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        foodImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true

        labelStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10).isActive = true
        labelStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        labelStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10).isActive = true

    }
}
