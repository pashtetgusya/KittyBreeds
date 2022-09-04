//
//  Constants.swift
//  KittyBreeds
//
//  Created by Pavel Yarovoi on 24.08.2022.
//

import Foundation

struct Constants {
    static let scheme = "https"
    
    static let host = "api.thecatapi.com"
    static let imageHost = "cdn2.thecatapi.com"
    
    static let kittyBreedsPath = "/v1/breeds"
    static let kittyBreedSearchPath = "/v1/breeds/search"
    
    static let kittyBreedImagePath = "/images"
    
    static let kittyBreedListCellIdentifier = "\(KittyBreedListCell.self)"
}
