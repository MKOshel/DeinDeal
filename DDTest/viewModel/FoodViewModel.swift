//
//  FoodViewModel.swift
//  DDTest
//
//  Created by Dragos Marinescu on 12/18/20.
//

import Foundation

typealias FoodCellConfig = TableCellConfigurator<FoodTableViewCell, FoodItem>
typealias FoodCategoriesCellConfig = TableCellConfigurator<FoodCategoryCollectionCell, [FoodCategory]>


struct FoodInputData {
    let service: Service
    let selectedCity: City
    let allCities: [City]
}


class FoodViewModel {
    
    let foodInputData: FoodInputData
    private var foodData: FoodData?
    
    init(foodInputData: FoodInputData) {
        self.foodInputData = foodInputData
    }
    
    func getItems(city: City? = nil, completion: @escaping (_ items: [CellConfigurator]?, _ foodData: FoodData?, _ error: APIError?) -> Void) {
        
        let cityId = city != nil ? city?.id ?? "" : foodInputData.selectedCity.id
        let foodEndpoint = Endpoint.init(path: "/foods/\(cityId)", queryItems: nil)
        
        foodInputData.service.getGenericData(url: foodEndpoint.url) { (foodData: FoodData?, error: APIError?) in
            if let err = error {
                completion(nil, nil, err)
                print("$$$$$$$$$ ERROR, \(err)")
            }
            
            self.foodData = foodData
            let foodItems = foodData?.items.map { FoodCellConfig(item: $0) }
            
            var items: [CellConfigurator] = [BannerCellConfig(item: BannerModel(title: foodData?.name ?? "",
                                                description: "Hold and press to change the address")),
                                             FoodCategoriesCellConfig(item: foodData?.foodCategories ?? [])]
            items.append(contentsOf: foodItems ?? [])
            
            completion(items, foodData, nil)
        }
    }
    
    func getFilteredItems(by categoryId: String) -> [CellConfigurator] {
        let filteredItems = foodData?.items.filter { $0.categories.contains(categoryId) }
        
        var items: [CellConfigurator] = [BannerCellConfig(item: BannerModel(title: foodData?.name ?? "",
                                            description: "Hold and press to change the address")),
                                         FoodCategoriesCellConfig(item: foodData?.foodCategories ?? [])]
        
        items.append(contentsOf: filteredItems?.map { FoodCellConfig(item: $0) } ?? [])
        
        return  items
        
    }
}
