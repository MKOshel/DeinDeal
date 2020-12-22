//
//  UIView+Extension.swift
//  DDTest
//
//  Created by Dragos Marinescu on 12/17/20.
//

import UIKit

extension UIView {
    func fixInView(_ container: UIView) {
        self.frame = container.bounds
        container.addSubview(self)

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0),
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0)
        ])
    }
}

@propertyWrapper
struct UsesAutoLayout<T> where T: UIView {
    var wrappedValue: T? {
        didSet {
            wrappedValue?.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    init(wrappedValue: T?) {
        self.wrappedValue = wrappedValue
        wrappedValue?.translatesAutoresizingMaskIntoConstraints = false
    }
}
