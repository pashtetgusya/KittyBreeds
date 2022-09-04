//
//  KittyBreedListViewModel.swift
//  KittyBreeds
//
//  Created by Pavel Yarovoi on 23.08.2022.
//

import Foundation
import RxSwift
import Alamofire

class KittyBreedListViewModel {
    
    // MARK: - Publish subjects
    public let kittyBreeds: PublishSubject<[KittyBreed]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error: PublishSubject<AFError> = PublishSubject()
    
    // MARK: - Private properties
    private let disposable = DisposeBag()
    
    // MARK: - Fetch data methods
    func fetchKittyBreeds() {
        
        self.loading.onNext(true)
        NetworkManager.shared.fetchData(
            path: Constants.kittyBreedsPath,
            type: [KittyBreed].self
        ) { (responce) in
            self.loading.onNext(false)
            switch responce {
            case .success(let breedsData):
                self.kittyBreeds.onNext(breedsData)
            case .failure(let error):
                self.error.onNext(error)
            }
        }
        
    }

    func fetchKittyBreed(breed query: String) {
        
        self.loading.onNext(true)
        NetworkManager.shared.fetchData(
            path: Constants.kittyBreedSearchPath,
            type: [KittyBreed].self,
            breedQueryName: query
        ) { (responce) in
            self.loading.onNext(false)
            switch responce {
            case .success(let breedData):
                self.kittyBreeds.onNext(breedData)
            case .failure(let error):
                self.error.onNext(error)
            }
        }
    }
    
}
