//
//  KittyBreedImageModel.swift
//  KittyBreeds
//
//  Created by Pavel Yarovoi on 23.08.2022.
//

import Foundation

struct KittyBreed: Codable {
    
    let id: String
    let name: String?
    let origin: String?
    let description: String?
    let imageID: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case origin
        case description
        case imageID = "reference_image_id"
    }
    
}
