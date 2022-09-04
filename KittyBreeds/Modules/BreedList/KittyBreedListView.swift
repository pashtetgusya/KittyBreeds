//
//  KittyBreedListView.swift
//  KittyBreeds
//
//  Created by Pavel Yarovoi on 23.08.2022.
//

import UIKit

final class KittyBreedListView: UIView {
    
    // MARK: - UIView elements
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
    
    let kittyBreedSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barStyle = .black
        searchBar.isTranslucent = true
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search kitty breed"
        searchBar.tintColor = .black
        searchBar.searchTextField.textColor = .white

        return searchBar
    }()
    
    let searchButtunItem: UIBarButtonItem = {
        let item = UIBarButtonItem(systemItem: .search)
        item.tintColor = .black
        
        return item
    }()
    
    let helpButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(systemItem: .bookmarks)
        item.tintColor = .black
        
        return item
    }()
    
    // MARK: - Init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        kittyBreedListTableView.refreshControl = kittyBreedListRefreshControl
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Public methods
extension KittyBreedListView {
            
    func getErrorAlert(error message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(actionOK)
        
        return alert
    }
    
}

// MARK: - Setup methods
private extension KittyBreedListView {
    
    func setupView() {
        backgroundColor = .systemPurple
        
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
