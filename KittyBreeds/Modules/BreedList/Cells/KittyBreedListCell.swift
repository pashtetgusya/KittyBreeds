//
//  KittyBreedListCell.swift
//  KittyBreeds
//
//  Created by Pavel Yarovoi on 24.08.2022.
//

import UIKit
import Kingfisher
import RxSwift

class KittyBreedListCell: UITableViewCell {
    
    // MARK: - Public properties
    var disposeBag = DisposeBag()
    
    // MARK: - UIView elements
    private let kittyBreedImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.lightGray.cgColor
        image.layer.cornerRadius = 50
        
        return image
    }()
    
    private let kittyBreedNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        
        return label
    }()
    
    private let kittyBreedDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.text = "Description"
        
        return label
    }()
    
    private let kittyBreedOriginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.italicSystemFont(ofSize: 13)
        label.textColor = .white
        
        return label
    }()
    
    private let kittyBreedInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        
        return stack
    }()
    
    let showKittyBreedInfoButton: UIButton = {
        let button = UIButton(type: .infoLight)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        
        return button
    }()
    
    // MARK: - Init methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        kittyBreedImageView.image = nil
        kittyBreedImageView.kf.cancelDownloadTask()
        disposeBag = DisposeBag()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 7, left: 15, bottom: 8, right: 15))
    }
    
}

// MARK: - Public methods
extension KittyBreedListCell {
    
    func setTextForBreedNameLabel(text: String) {
        kittyBreedNameLabel.text = text
    }
    
    func setTextForBreedDescriptionLabel(text: String) {
        kittyBreedDescriptionLabel.text = text
    }
    
    func setTextForBreedOriginLabel(text: String) {
        kittyBreedOriginLabel.text = "origin: \(text)"
    }
    
    func setImageForBreedImageView(referenceImageID: String) {
        let imagePath = "\(Constants.kittyBreedImagePath)/\(referenceImageID).jpg"
        let imageURL = NetworkManager.shared.createURL(host: Constants.imageHost, path: imagePath)
        
        kittyBreedImageView.kf.indicatorType = .activity
        kittyBreedImageView.kf.setImage(
            with: imageURL,
            placeholder: UIImage(named: "NoKittyBreedImage"))
    }
    
}

// MARK: - Setup methods
private extension KittyBreedListCell {
    
    func setupView() {
        backgroundColor = .clear
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = .darkGray
        
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(kittyBreedImageView)
        contentView.addSubview(kittyBreedInfoStackView)
        contentView.addSubview(showKittyBreedInfoButton)
        kittyBreedInfoStackView.addSubview(kittyBreedNameLabel)
        kittyBreedInfoStackView.addSubview(kittyBreedDescriptionLabel)
        kittyBreedInfoStackView.addSubview(kittyBreedOriginLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            kittyBreedImageView.heightAnchor.constraint(equalToConstant: 100),
            kittyBreedImageView.widthAnchor.constraint(equalToConstant: 100),
            kittyBreedImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            kittyBreedImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            kittyBreedImageView.trailingAnchor.constraint(equalTo: kittyBreedInfoStackView.leadingAnchor, constant: -15),
            
            kittyBreedInfoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            kittyBreedInfoStackView.leadingAnchor.constraint(equalTo: kittyBreedImageView.trailingAnchor, constant: 15),
            kittyBreedInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            kittyBreedInfoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            kittyBreedNameLabel.heightAnchor.constraint(equalToConstant: 18),
            kittyBreedNameLabel.topAnchor.constraint(equalTo: kittyBreedInfoStackView.topAnchor),
            kittyBreedNameLabel.leadingAnchor.constraint(equalTo: kittyBreedInfoStackView.leadingAnchor),
            kittyBreedNameLabel.trailingAnchor.constraint(equalTo: kittyBreedInfoStackView.trailingAnchor),
            kittyBreedNameLabel.bottomAnchor.constraint(equalTo: kittyBreedDescriptionLabel.topAnchor),
            
            kittyBreedDescriptionLabel.heightAnchor.constraint(equalToConstant: 66),
            kittyBreedDescriptionLabel.topAnchor.constraint(equalTo: kittyBreedNameLabel.bottomAnchor),
            kittyBreedDescriptionLabel.leadingAnchor.constraint(equalTo: kittyBreedInfoStackView.leadingAnchor),
            kittyBreedDescriptionLabel.trailingAnchor.constraint(equalTo: kittyBreedInfoStackView.trailingAnchor),
            kittyBreedDescriptionLabel.bottomAnchor.constraint(equalTo: kittyBreedOriginLabel.topAnchor, constant: -7),

            kittyBreedOriginLabel.heightAnchor.constraint(equalToConstant: 15),
            kittyBreedOriginLabel.topAnchor.constraint(equalTo: kittyBreedDescriptionLabel.bottomAnchor, constant: 7),
            kittyBreedOriginLabel.leadingAnchor.constraint(equalTo: kittyBreedInfoStackView.leadingAnchor),
            kittyBreedOriginLabel.trailingAnchor.constraint(equalTo: kittyBreedInfoStackView.trailingAnchor),
            kittyBreedOriginLabel.bottomAnchor.constraint(equalTo: kittyBreedInfoStackView.bottomAnchor),
            
            showKittyBreedInfoButton.widthAnchor.constraint(equalToConstant: 20),
            showKittyBreedInfoButton.heightAnchor.constraint(equalToConstant: 20),
            showKittyBreedInfoButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            showKittyBreedInfoButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
    
}
