//
//  BaseCollectionView.swift
//  DDTest
//
//  Created by Dragos Marinescu on 12/17/20.
//

import Foundation

import UIKit

class BaseCollectionView: UICollectionView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            self.invalidateIntrinsicContentSize()
      }
}
    override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }
    
}
