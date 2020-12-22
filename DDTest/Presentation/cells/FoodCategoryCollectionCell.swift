//
//  FoodCategoryCollectionCell.swift
//  DDTest
//
//  Created by Dragos Marinescu on 12/18/20.
//

import UIKit

protocol CategoriesDelegate {
    func didSelectCategory(foodCategory: FoodCategory, isSelected: Bool)
}

class FoodCategoryCollectionCell: UITableViewCell, ConfigurableCell {
    private var categories: [FoodCategory] = []
    private var selectedIndex: IndexPath?
    var delegate: CategoriesDelegate?
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    
    func configure(data categories: [FoodCategory]) {
        if self.categories != categories {
            self.categories = categories
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CategoryCollectionViewCell.self))
        collectionView.allowsMultipleSelection = false
        flowLayout.estimatedItemSize = CGSize(width: 80, height: 80)
    }
}

extension FoodCategoryCollectionCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCollectionViewCell.self), for: indexPath) as! CategoryCollectionViewCell
        let category = categories[indexPath.row]
        
        cell.configure(with: category)
        
        return cell
    }
}

extension FoodCategoryCollectionCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleSelectedState(indexPath: indexPath)
        
        let category = categories[indexPath.row]
        delegate?.didSelectCategory(foodCategory: category, isSelected: selectedIndex != nil)
    }
    
    private func handleSelectedState(indexPath: IndexPath) {
        if selectedIndex == indexPath {
            selectedIndex = nil
            collectionView.deselectItem(at: indexPath, animated: false)
        } else {
            selectedIndex = indexPath
        }
    }
}
