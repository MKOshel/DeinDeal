//
//  BaseNavigationController.swift
//  DDTest
//
//  Created by Dragos Marinescu on 12/17/20.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeAppearance()
    }
    
    private func customizeAppearance() {
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.tintColor = .black
    }
}

protocol CartButtonConfigurable where Self: UIViewController {
    func addCartButton()
}

extension CartButtonConfigurable {
    func addCartButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        button.setImage(UIImage(named: "cart_grey"), for: .normal)
        let rightBarButtonItem = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}
