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
    static let kittyBreedsPath = "/v1/breeds"
    static let kittyBreedSearchPath = "/v1/breeds/search"
    static let kittyBreedImagesSearchPath = "/v1/images/search"
    
    static let kittyBreedListCellIdentifier = "\(KittyBreedListCell.self)"
}
