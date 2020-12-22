//
//  Food.swift
//  DDTest
//
//  Created by Dragos Marinescu on 12/18/20.
//

import Foundation

struct FoodData: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case items
        case foodCategories = "facetCategories"
    }
    let id: String
    let name: String
    let items: [FoodItem]
    let foodCategories: [FoodCategory]
}

struct FoodItem: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case subtitle
        case images
        case categories = "myThemes"
    }
    
    let id: Int
    let title: String
    let subtitle: String
    let images: FoodImage
    let categories: [String]
}

struct FoodCategory: Decodable {
    let id: String
    let label: String
    let icon: String
}

extension FoodCategory: Equatable {
    static func == (lhs: FoodCategory, rhs: FoodCategory) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }
}

struct FoodImage: Decodable {
    let cover: String
}
