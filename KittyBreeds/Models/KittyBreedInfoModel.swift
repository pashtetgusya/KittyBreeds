//
//  KittyBreedInfoModel.swift
//  KittyBreeds
//
//  Created by Pavel Yarovoi on 25.08.2022.
//

import Foundation

struct KittyBreedInfo: Codable {
    
    let breeds: [BreedInfo]
    
}

struct BreedInfo: Codable {
    
    let id: String
    let name: String?
    let origin: String?
    let description: String?
    let temperament: String?

    let adaptability: Int?
    let affection_level: Int?
    let child_friendly: Int?
    let cat_friendly: Int?
    let dog_friendly: Int?
    let energy_level: Int?
    let grooming: Int?
    let health_issues: Int?
    let intelligence: Int?
    let shedding_level: Int?
    let social_needs: Int?
    let stranger_friendly: Int?
    let vocalisation: Int?
    let bidability: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, origin, description, temperament
        case adaptability
        case affection_level = "affection_level"
        case child_friendly = "child_friendly"
        case cat_friendly = "cat_friendly"
        case dog_friendly = "dog_friendly"
        case energy_level = "energy_level"
        case grooming
        case health_issues = "health_issues"
        case intelligence
        case shedding_level = "shedding_level"
        case social_needs = "social_needs"
        case stranger_friendly = "stranger_friendly"
        case vocalisation
        case bidability
    }
    
}
