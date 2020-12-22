//
//  CollectionCell.swift
//  DDTest
//
//  Created by Dragos Marinescu on 12/17/20.
//

import UIKit

protocol CitiesDelegate {
    func didSelectCity(city: City)
}

class CollectionCell: UITableViewCell, ConfigurableCell {
    var cities: [City] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var delegate: CitiesDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: String(describing: CityCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CityCollectionViewCell.self))
    }
    
    func configure(data: [City]) {
        cities = data
    }
}

extension CollectionCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CityCollectionViewCell.self), for: indexPath) as! CityCollectionViewCell
        let city = cities[indexPath.row]
        
        cell.configure(with: city)
        
        return cell
    }    
}

extension CollectionCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        delegate?.didSelectCity(city: city)
    }
}

extension CollectionCell: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            CGSize(width: 200, height: 120)
        }
    }
