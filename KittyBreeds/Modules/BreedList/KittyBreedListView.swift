//
//  KittyBreedListView.swift
//  KittyBreeds
//
//  Created by Pavel Yarovoi on 23.08.2022.
//

import UIKit

class KittyBreedListView: UIView {
    
    let kittyBreedListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        
        tableView.register(KittyBreedListCell.self, forCellReuseIdentifier: Constants.kittyBreedListCellIdentifier)
        
        return tableView
    }()
    
    let kittyBreedListRefreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Update kitty breed list")
        
        return refresh
    }()
    
    let breedSearchBar: UISearchBar = {
        let width = UIScreen.main.bounds.width - 72
        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: -5, width: width, height: .leastNormalMagnitude))
        searchBar.placeholder = "Search kitty breed"
        
        return searchBar
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        kittyBreedListTableView.refreshControl = kittyBreedListRefreshControl
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNavigationItem(in controller: UIViewController) {
        let leftNavBarButton = UIBarButtonItem(customView: breedSearchBar)
        let rightNavBarButton = UIBarButtonItem(systemItem: .refresh)
        rightNavBarButton.tintColor = .black
        controller.navigationItem.leftBarButtonItem = leftNavBarButton
        controller.navigationItem.rightBarButtonItem = rightNavBarButton
    }
        
    func setupErrorAlert(error message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(actionOK)
        
        return alert
    }
    
}

private extension KittyBreedListView {
    
    func setupView() {
        backgroundColor = .white
        
        addSubview(kittyBreedListTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            kittyBreedListTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            kittyBreedListTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            kittyBreedListTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            kittyBreedListTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
