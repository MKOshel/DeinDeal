//
//  HomeViewModel.swift
//  DDTest
//
//  Created by Dragos Marinescu on 12/17/20.
//

import Foundation

typealias BannerCellConfig = TableCellConfigurator<BannerCell, BannerModel>
typealias PromoCellConfig = TableCellConfigurator<PromoCell, String>
typealias CollectionCellConfig = TableCellConfigurator<CollectionCell, [City]>

class HomeViewModel {
    
    private let service: Service
    var cityData: CityData?
    
    init(service: Service) {
        self.service = service
    }
    
    func getItems() -> [CellConfigurator] {
        [BannerCellConfig(item: BannerModel(title: "Hungry? We deliver!",
                                            description: "Tap here to select an address")),
                                PromoCellConfig(item: "")]
    }
    
    func getCities(completion: @escaping  (_ items: [CellConfigurator]?, _ error: APIError?) -> Void) {
        let endpoint = Endpoint(path: "/settings", queryItems: nil)
        
        service.getGenericData(url: endpoint.url) { [weak self] (cityData: CityData?, error: APIError?) in
            if let err = error {
                completion(nil, err)
                print("$$$$$$$$$ ERROR, \(err)")
            }
            
            self?.cityData = cityData
            let items: [CellConfigurator] = [BannerCellConfig(item: BannerModel(title: "Hungry? We deliver!",
                                                description: "Tap here to select an address")),
                                             CollectionCellConfig(item: cityData?.cities ?? []),
                                             PromoCellConfig(item: "")]
            
            completion(items, nil)
        }
    }
}
