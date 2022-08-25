//
//  KittyBreedInfoController.swift
//  KittyBreeds
//
//  Created by Pavel Yarovoi on 24.08.2022.
//

import UIKit
import RxSwift

class KittyBreedInfoController: UIViewController {
    
    var kittyBreedID: String?
    
    private let disposeBag = DisposeBag()
    private let kittyBreedInfoView = KittyBreedInfoView()
    private let kittyBreedInfoViewModel = KittyBreedInfoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        
        guard let kittyBreedIdentifire = kittyBreedID else {
            return
        }
        kittyBreedInfoViewModel.kittyBreedID = kittyBreedIdentifire
        kittyBreedInfoViewModel.fetchKittyBreedInfo()
    }

}
