//
//  City.swift
//  DDTest
//
//  Created by Dragos Marinescu on 12/17/20.
//

import Foundation

struct CityData: Decodable {
    let cities: [City]
}

struct City: Decodable {
    let id: String
    let channelInfo: ChannelInfo
}

struct ChannelInfo: Decodable {
    let title: String
    let images: Image
}

struct Image: Decodable {
    let small: String
    let large: String
}
