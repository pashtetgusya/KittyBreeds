//
//  KittyBreedInfoViewModel.swift
//  KittyBreeds
//
//  Created by Pavel Yarovoi on 25.08.2022.
//

import Foundation
import Alamofire
import RxSwift

class KittyBreedInfoViewModel {
    
    public let kittyBreedInfo: PublishSubject<[KittyBreedInfo]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error: PublishSubject<AFError> = PublishSubject()
    
    private let disposable = DisposeBag()
    
    var kittyBreedID: String = ""
 
    func fetchKittyBreedInfo() {
        NetworkManager.shared.fetchData(
            path: Constants.kittyBreedSearchPath,
            type: [KittyBreedInfo].self,
            breedQueryID: kittyBreedID
        ) { responce in
            self.loading.onNext(false)
            switch responce {
            case .success(let breedInfoData):
                self.kittyBreedInfo.onNext(breedInfoData)
            case .failure(let error):
                self.error.onNext(error)
            }
        }
    }
    
}
