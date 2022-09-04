//
//  KittyBreedListController.swift
//  KittyBreeds
//
//  Created by Pavel Yarovoi on 23.08.2022.
//

import UIKit
import RxSwift
import RxCocoa

class KittyBreedListController: UIViewController, UISearchControllerDelegate {
    
    // MARK: - Private properties
    private let disposeBag = DisposeBag()
    private let kittyBreedListView = KittyBreedListView()
    private let kittyBreedListViewModel = KittyBreedListViewModel()
    
    private var isSearch = false
    
    // MARK: - Lifecycle
    override func loadView() {
        view = kittyBreedListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showOrHideSearchBarButtons(isHidden: false)
        
        setupBindings()
        kittyBreedListViewModel.fetchKittyBreeds()
    }
                
}

// MARK: - UIScrollViewDelegate
extension KittyBreedListController: UIScrollViewDelegate { }

// MARK: - UISearchBarDelegate
extension KittyBreedListController: UISearchBarDelegate { }

// MARK: - RX bindings
private extension KittyBreedListController {
    func setupBindings() {
        bindNavigationItem()
        bindSearchBar()
        bindTableView()
        bindRefreshControl()
        bindErrorAlert()
    }
    
    func bindNavigationItem() {
        // Left bitton item tap
        navigationItem
            .leftBarButtonItem?.rx
            .tap
            .subscribe(onNext:  { [weak self] in
                self?.kittyBreedListView.kittyBreedSearchBar.becomeFirstResponder()
                self?.startSearch(isHidden: false)
            })
            .disposed(by: disposeBag)
    }
    
    func bindSearchBar() {
        // Set delegate
        kittyBreedListView
            .kittyBreedSearchBar.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        // Search
        kittyBreedListView
            .kittyBreedSearchBar.rx
            .text
            .orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] breedName in
                self?.kittyBreedListViewModel.fetchKittyBreed(breed: breedName)
                self?.isSearch.toggle()
            })
            .disposed(by: disposeBag)

        // Search button clicked
        kittyBreedListView
            .kittyBreedSearchBar.rx
            .searchButtonClicked
            .subscribe(onNext: { [weak self] in
                self?.becomeFirstResponder()
            })
            .disposed(by: disposeBag)

        // Cancel button clicked
        kittyBreedListView
            .kittyBreedSearchBar.rx
            .cancelButtonClicked
            .subscribe(onNext: { [weak self] in
                if self?.isSearch == true {
                    self?.kittyBreedListViewModel.fetchKittyBreeds()
                    self?.isSearch.toggle()
                }
                self?.startSearch(isHidden: true)
            })
            .disposed(by: disposeBag)
    }
    
    func bindTableView() {
        // Set delegate
        kittyBreedListView
            .kittyBreedListTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        // Table items
        kittyBreedListViewModel
            .kittyBreeds
            .bind(to: kittyBreedListView.kittyBreedListTableView.rx.items(
                cellIdentifier: Constants.kittyBreedListCellIdentifier,
                cellType: KittyBreedListCell.self)
            ) { [weak self] index, breedData, cell in
                
                cell.setImageForBreedImageView(referenceImageID: breedData.imageID ?? "")
                cell.setTextForBreedNameLabel(text: breedData.name ?? "")
                cell.setTextForBreedDescriptionLabel(text: breedData.description ?? "")
                cell.setTextForBreedOriginLabel(text: breedData.origin ?? "")

                // Show breed info controller on tap
                cell.showKittyBreedInfoButton.rx
                    .tap
                    .bind {
                        self?.showBreedInfoView(with: breedData.id)
                    }.disposed(by: cell.disposeBag)
                
            }.disposed(by: disposeBag)
    }
    
    func bindRefreshControl() {
        // Control event
        kittyBreedListView
            .kittyBreedListRefreshControl.rx
            .controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                self?.kittyBreedListViewModel.fetchKittyBreeds()
            })
            .disposed(by: disposeBag)
        
        // Show or hide
        kittyBreedListViewModel
            .loading
            .bind(to: kittyBreedListView.kittyBreedListRefreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
    }
    
    func bindErrorAlert() {
        // Show error alert
        kittyBreedListViewModel
            .error
            .subscribe { [weak self] error in
                self?.showErrorAlert(error: error.debugDescription)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - Navigation
private extension KittyBreedListController {
    func showBreedInfoView(with id: String) {
        let viewController = KittyBreedInfoController()
        viewController.kittyBreedID = id
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showErrorAlert(error: String) {
        let allert = kittyBreedListView.getErrorAlert(error: error)
        present(allert, animated: true)
    }
}

// MARK: - Navigation item
private extension KittyBreedListController {
    func showOrHideSearchBarButtons(isHidden: Bool) {
        if !isHidden {
            navigationItem.leftBarButtonItem = kittyBreedListView.searchButtunItem
            navigationItem.rightBarButtonItem = kittyBreedListView.helpButtonItem
        } else {
            navigationItem.leftBarButtonItem = nil
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    func startSearch(isHidden: Bool) {
        showOrHideSearchBarButtons(isHidden: !isHidden)
        navigationItem.titleView = isHidden ? nil : kittyBreedListView.kittyBreedSearchBar
    }

}
