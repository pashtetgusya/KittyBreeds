//
//  NetworkManager.swift
//  KittyBreeds
//
//  Created by Pavel Yarovoi on 23.08.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData<T: Codable>(
        path: String,
        type: T.Type,
        breedQueryName: String? = nil,
        breedQueryID: String? = nil,
        completionHandler: @escaping (Result<T, AFError>
        ) -> Void
    ) {
        let url = createURL(path: path)
        let parameters = prepareParameters(breedQueryName: breedQueryName, breedQueryID: breedQueryID)
        
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: type) { responce in
                completionHandler(responce.result)
            }
    }
    
    func createURL(host: String = Constants.host, path: String) -> URL{
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = host
        urlComponents.path = path
        
        return urlComponents.url!
    }
    
}

private extension NetworkManager {
    
    func prepareParameters(breedQueryName: String?, breedQueryID: String?) -> [String: String] {
        var parameters = [String: String]()
        
        guard ProcessInfo.processInfo.environment["API_KEY"] != nil else {
            return parameters
        }

//        parameters["api_key"] = apiKey
        parameters["api_key"] = "ec1935fc-e1db-4bbe-9b11-e30acc3523f0"
        
        if let name = breedQueryName {
            parameters["q"] = name
        }
        if let id = breedQueryID {
            parameters["breed_ids"] = id
        }
        
        return parameters

    }

}
