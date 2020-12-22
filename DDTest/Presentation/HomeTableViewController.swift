//
//  MainTableViewController.swift
//  DDTest
//
//  Created by Dragos Marinescu on 12/17/20.
//

import UIKit

class HomeTableViewController: TableViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    private let viewModel = HomeViewModel(service: ServiceImplementation())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCells()
        items = viewModel.getItems()
        load()
    }
    
    func load() {
        viewModel.getCities { [weak self] (items, error) in
            if let items = items {
                self?.items = items
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.tableView.tableHeaderView = nil
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let cell = cell as? CollectionCell {
            cell.delegate = self
        }
        return cell
    }
    
    func setupCells() {
        tableView.register(UINib(nibName: String(describing: BannerCell.self), bundle: nil), forCellReuseIdentifier: String(describing: BannerCell.self))
        tableView.register(UINib(nibName: String(describing: PromoCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PromoCell.self))
        tableView.register(UINib(nibName: String(describing: CollectionCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CollectionCell.self))
    }
}

extension HomeTableViewController: CitiesDelegate {
    func didSelectCity(city: City) {
        let foodTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: String(describing: FoodTableViewController.self)) as! FoodTableViewController
        
        let inputData = FoodInputData(service: ServiceImplementation(), selectedCity: city, allCities: viewModel.cityData?.cities ?? [])
        foodTableViewController.viewModel = FoodViewModel(foodInputData: inputData)
        
        navigationController?.pushViewController(foodTableViewController, animated: true)
    }
}
