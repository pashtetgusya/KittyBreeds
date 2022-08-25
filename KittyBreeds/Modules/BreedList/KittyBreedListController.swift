//
//  KittyBreedListController.swift
//  KittyBreeds
//
//  Created by Pavel Yarovoi on 23.08.2022.
//

import UIKit
import RxSwift
import RxCocoa

class KittyBreedListController: UIViewController, UIScrollViewDelegate {
    
    private let disposeBag = DisposeBag()
    private let kittyBreedListView = KittyBreedListView()
    private let kittyBreedListViewModel = KittyBreedListViewModel()
    
    override func loadView() {
        super.loadView()
        
        self.view = kittyBreedListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kittyBreedListView.setupNavigationItem(in: self)
        
        setupBindings()
        kittyBreedListViewModel.fetchKittyBreeds()
    }
        
}

private extension KittyBreedListController {
    
    func setupBindings() {
        
        navigationItem
            .rightBarButtonItem?.rx
            .tap
            .bind { [weak self] in
                self?.kittyBreedListViewModel.fetchKittyBreeds()
            }
            .disposed(by: disposeBag)
        
        kittyBreedListView
            .kittyBreedListTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        kittyBreedListView
            .breedSearchBar.rx
            .text
            .orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] breedName in
                self?.kittyBreedListViewModel.fetchKittyBreed(breed: breedName)
            })
            .disposed(by: disposeBag)
        
        kittyBreedListView
            .kittyBreedListRefreshControl.rx
            .controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                self?.kittyBreedListViewModel.fetchKittyBreeds()
            })
            .disposed(by: disposeBag)
        
        kittyBreedListViewModel
            .loading
            .bind(to: kittyBreedListView.kittyBreedListRefreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        kittyBreedListViewModel
            .kittyBreeds
            .bind(to: kittyBreedListView.kittyBreedListTableView.rx.items(
                cellIdentifier: Constants.kittyBreedListCellIdentifier,
                cellType: KittyBreedListCell.self)
            ) { [weak self] index, breedData, cell in
                
                cell.setImageForBreedImageView(urlString: breedData.image?.url ?? "")
                cell.setTextForBreedNameLabel(text: breedData.name ?? "")
                cell.setTextForBreedDescriptionLabel(text: breedData.description ?? "")
                cell.setTextForBreedOriginLabel(text: breedData.origin ?? "")

                cell.showKittyBreedInfoButton.rx
                    .tap
                    .bind {
                        self?.showBreedInfoView(with: breedData.id)
                    }.disposed(by: cell.disposeBag)
                
            }.disposed(by: disposeBag)
        
        kittyBreedListViewModel
            .error
            .subscribe { [weak self] error in
                guard let allert = self?.kittyBreedListView.setupErrorAlert(error: error.debugDescription) else {
                    return
                }
                self?.present(allert, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func showBreedInfoView(with id: String) {
        let viewController = KittyBreedInfoController()
        viewController.kittyBreedID = id
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
