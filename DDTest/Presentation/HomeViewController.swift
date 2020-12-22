//
//  HomeViewController.swift
//  DDTest
//
//  Created by Dragos Marinescu on 12/17/20.
//

import UIKit

class HomeViewController: UIViewController, CartButtonConfigurable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCartButton()
    }
}
