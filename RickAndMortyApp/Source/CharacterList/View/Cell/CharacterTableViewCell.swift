//
//  CharacterTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Ahmer Akhter on 18/05/2023.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    private static let REUSE_ID = "CharacterTableViewCell"
    
    private let containerView = UIView()
    private let nameLabel = UILabel()
    private let speciesLabel = UILabel()
    private let statusLabel = UILabel()
    private let profileImageView = UIImageView()
    private let statusContainerView = UIView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabels()
        setupImageViews()
        setupStatusView()
        setupContainerView()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func
    
    private func setupLabels(){
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        speciesLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
    }
    
    private func setupImageViews(){
        profileImageView.layer.cornerRadius = ViewSizeConstants.CHARACTER_LIST_CONTENT_VIEW_PROFILE_IMAGE_SIZE.height / 2
        profileImageView.backgroundColor = .red
        
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
    
    private func setupContainerView(){
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        
        NSLayoutConstraint.activate([
        
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),

        
        ])
    }
    
    private func layoutUI(){
        
        let views = [profileImageView, nameLabel, speciesLabel, statusContainerView]
        
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
        
            profileImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            profileImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            profileImageView.widthAnchor.constraint(equalToConstant: ViewSizeConstants.CHARACTER_LIST_CONTENT_VIEW_PROFILE_IMAGE_SIZE.width),
            profileImageView.heightAnchor.constraint(equalToConstant: ViewSizeConstants.CHARACTER_LIST_CONTENT_VIEW_PROFILE_IMAGE_SIZE.height),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            
            speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            speciesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            statusContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            statusContainerView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            statusContainerView.heightAnchor.constraint(equalToConstant: ViewSizeConstants.CHARACTER_LIST_CONTENT_VIEW_STATUS_CONTAINER_VIEW_SIZE.height),
            statusContainerView.widthAnchor.constraint(equalToConstant: ViewSizeConstants.CHARACTER_LIST_CONTENT_VIEW_STATUS_CONTAINER_VIEW_SIZE.width),
        
        
        ])
        
        
    }
    
}
