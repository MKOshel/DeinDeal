//
//  FoodTableViewController.swift
//  DDTest
//
//  Created by Dragos Marinescu on 12/18/20.
//

import UIKit

class FoodTableViewController: TableViewController, CartButtonConfigurable {
    var viewModel: FoodViewModel!
    var allItems: [CellConfigurator]!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCells()
        addCartButton()
        load()
    }
    
    private func load(city: City? = nil) {
        viewModel.getItems(city: city, completion: { [weak self] (items, foodData, error) in
            if let items = items {
                self?.allItems = items
                self?.items = items
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.tableView.tableHeaderView = nil
                    self?.title = foodData?.name
                }
            }
        })
    }
    
    func setupCells() {
        tableView.register(UINib(nibName: String(describing: BannerCell.self), bundle: nil), forCellReuseIdentifier: String(describing: BannerCell.self))
        tableView.register(UINib(nibName: String(describing: FoodCategoryCollectionCell.self), bundle: nil), forCellReuseIdentifier: String(describing: FoodCategoryCollectionCell.self))
        tableView.register(FoodTableViewCell.self, forCellReuseIdentifier: String(describing: FoodTableViewCell.self))
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let cell = cell as? FoodCategoryCollectionCell {
            cell.delegate = self
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { [weak self] _ in
            guard let strongSelf = self, indexPath.row == 0 else { return nil }
            
            return strongSelf.makeContextMenu(cities: strongSelf.viewModel.foodInputData.allCities)
        })
    }
    
    func makeContextMenu(cities: [City]) -> UIMenu {
        var menuItems = [UIAction]()
        cities.forEach { city in
            let action = UIAction(title: city.channelInfo.title) { action in
                self.load(city: city)
            }
            menuItems.append(action)
        }

        return UIMenu(title: "Choose City", children: menuItems)
    }
}

extension FoodTableViewController: CategoriesDelegate {
    func didSelectCategory(foodCategory: FoodCategory, isSelected: Bool) {
         items = isSelected ? viewModel.getFilteredItems(by: foodCategory.id) : allItems
         tableView.reloadData()
    }
}

extension FoodTableViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}
