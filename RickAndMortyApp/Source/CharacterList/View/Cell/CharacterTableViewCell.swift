//
//  CharacterTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Ahmer Akhter on 18/05/2023.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    static let REUSE_ID = "CharacterTableViewCell"
    
    private let containerView = UIView()
    private let nameLabel = UILabel()
    private let speciesLabel = UILabel()
    private let statusLabel = UILabel()
    private let profileImageView = UIImageView()
    private let statusContainerView = UIView()
    private let labelStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLabels()
        setupImageViews()
        setupStatusView()
        setupLabelStackView()
        setupContainerView()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func set(character: CharacterProfile){
        nameLabel.text = character.name
        speciesLabel.text = character.species
        statusLabel.text = character.status.rawValue.capitalized
        profileImageView.setImageWithUrl(url: character.imageURL)
        setStatusContainerViewColor(status: character.status)
    }
    
    private func setStatusContainerViewColor(status: CharacterStatus){
        switch status{
        case .Alive:
            statusContainerView.backgroundColor = .systemGreen
        case .Dead:
            statusContainerView.backgroundColor = .systemRed
        case .unknown:
            statusContainerView.backgroundColor = .systemGray

        }
    }
    
    private func setupView(){
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    private func setupLabels(){
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        speciesLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        statusLabel.font = UIFont.preferredFont(forTextStyle: .body)

        statusLabel.textAlignment = .center
        statusLabel.adjustsFontSizeToFitWidth = true
        statusLabel.minimumScaleFactor = 0.8
    }
    
    private func setupImageViews(){
        profileImageView.layer.cornerRadius = ViewSizeConstants.CHARACTER_LIST_CONTENT_VIEW_PROFILE_IMAGE_SIZE.height / 2
        profileImageView.backgroundColor = .red
        profileImageView.clipsToBounds = true
    }
    
    private func setupStatusView(){
        
        statusContainerView.layer.cornerRadius = ViewSizeConstants.CHARACTER_LIST_CONTENT_VIEW_STATUS_CONTAINER_VIEW_SIZE.height / 2
        statusContainerView.backgroundColor = .systemGreen
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusContainerView.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: statusContainerView.topAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: statusContainerView.leadingAnchor, constant: 8),
            statusLabel.trailingAnchor.constraint(equalTo: statusContainerView.trailingAnchor, constant: -8),
            statusLabel.bottomAnchor.constraint(equalTo: statusContainerView.bottomAnchor),
        ])
        
    }
    
    private func setupLabelStackView(){
        labelStackView.addArrangedSubview(nameLabel)
        labelStackView.addArrangedSubview(speciesLabel)
        labelStackView.axis = .vertical
        labelStackView.distribution = .equalCentering
    }
    
    private func setupContainerView(){
        containerView.backgroundColor = .secondarySystemBackground
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        
        NSLayoutConstraint.activate([
        
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

        
        ])
    }
    
    private func layoutUI(){
        
        let views = [profileImageView, labelStackView, statusContainerView]
        
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
        
            profileImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: ViewSizeConstants.CHARACTER_LIST_CONTENT_VIEW_PROFILE_IMAGE_SIZE.width),
            profileImageView.heightAnchor.constraint(equalToConstant: ViewSizeConstants.CHARACTER_LIST_CONTENT_VIEW_PROFILE_IMAGE_SIZE.height),
            
            
            statusContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            statusContainerView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            statusContainerView.heightAnchor.constraint(equalToConstant: ViewSizeConstants.CHARACTER_LIST_CONTENT_VIEW_STATUS_CONTAINER_VIEW_SIZE.height),
            statusContainerView.widthAnchor.constraint(equalToConstant: ViewSizeConstants.CHARACTER_LIST_CONTENT_VIEW_STATUS_CONTAINER_VIEW_SIZE.width),
        
            
            labelStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            labelStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            labelStackView.trailingAnchor.constraint(equalTo: statusContainerView.leadingAnchor, constant: -8),
            labelStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
            
//            nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
//            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
//
//            speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
//            speciesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

        
        ])
        
        
    }
    
}
