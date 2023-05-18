//
//  CharacterTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Ahmer Akhter on 18/05/2023.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    static let REUSE_ID = "CharacterTableViewCell"
    
    // MARK: UI Elements
    private let containerView = UIView()
    private let nameLabel = UILabel()
    private let speciesLabel = UILabel()
    private let statusLabel = UILabel()
    private let profileImageView = UIImageView()
    private let statusContainerView = UIView()
    private let labelStackView = UIStackView()
    
    // MARK: Init Functions
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        /// Setup the view
        setupView()
        
        /// Setup the labels
        setupLabels()
        
        /// Setup the image views
        setupImageViews()
        
        /// Setup the status view
        setupStatusView()
        
        /// Setup the label stack view
        setupLabelStackView()
        
        /// Setup the container view
        setupContainerView()
        
        // Layout the UI elements
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public Functions
    /// Set the character data for the cell
    func set(character: CharacterProfile) {
        nameLabel.text = character.name
        speciesLabel.text = character.species
        statusLabel.text = character.status.rawValue.capitalized
        profileImageView.setImageWithUrl(url: character.imageURL)
        setStatusContainerViewColor(status: character.status)
    }
    
    // MARK: Private Functions
    /// Set the color of the status container view based on the character's status
    private func setStatusContainerViewColor(status: CharacterStatus) {
        switch status {
        case .Alive:
            statusContainerView.backgroundColor = .systemGreen
        case .Dead:
            statusContainerView.backgroundColor = .systemRed
        case .unknown:
            statusContainerView.backgroundColor = .systemGray
        }
    }
    
    private func setupView() {
        /// Set the background color of the cell to clear
        self.backgroundColor = .clear
        
        /// Disable the selection style of the cell
        self.selectionStyle = .none
    }
    
    private func setupLabels() {
        /// Set the font styles for the labels
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        speciesLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        statusLabel.font = UIFont.preferredFont(forTextStyle: .body)

        /// Set the alignment and scaling properties for the status label
        statusLabel.textAlignment = .center
        statusLabel.adjustsFontSizeToFitWidth = true
        statusLabel.minimumScaleFactor = 0.8
    }
    
    private func setupImageViews() {
        /// Set the corner radius and background color of the profile image view
        profileImageView.layer.cornerRadius = ViewSizeConstants.CHARACTER_LIST_CONTENT_VIEW_PROFILE_IMAGE_SIZE.height / 2
        profileImageView.backgroundColor = .red
        profileImageView.clipsToBounds = true
    }
    
    private func setupStatusView() {
        /// Set the corner radius and initial background color of the status container view
        statusContainerView.layer.cornerRadius = ViewSizeConstants.CHARACTER_LIST_CONTENT_VIEW_STATUS_CONTAINER_VIEW_SIZE.height / 2
        statusContainerView.backgroundColor = .systemGreen
        
        /// Configure constraints for the status label within the status container view
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusContainerView.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: statusContainerView.topAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: statusContainerView.leadingAnchor, constant: 8),
            statusLabel.trailingAnchor.constraint(equalTo: statusContainerView.trailingAnchor, constant: -8),
            statusLabel.bottomAnchor.constraint(equalTo: statusContainerView.bottomAnchor),
        ])
    }
    
    private func setupLabelStackView() {
        /// Add the name and species labels to the stack view
        labelStackView.addArrangedSubview(nameLabel)
        labelStackView.addArrangedSubview(speciesLabel)
        
        /// Set the axis and distribution properties of the stack view
        labelStackView.axis = .vertical
        labelStackView.distribution = .equalCentering
    }
    
    private func setupContainerView() {
        /// Set the background color of the container view
        containerView.backgroundColor = .secondarySystemBackground
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            /// Set constraints to position the container view within the cell
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    private func layoutUI() {
        let views = [profileImageView, labelStackView, statusContainerView]
        
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            /// Set constraints to position the profile image view
            profileImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: ViewSizeConstants.CHARACTER_LIST_CONTENT_VIEW_PROFILE_IMAGE_SIZE.width),
            profileImageView.heightAnchor.constraint(equalToConstant: ViewSizeConstants.CHARACTER_LIST_CONTENT_VIEW_PROFILE_IMAGE_SIZE.height),
            
            /// Set constraints to position the status container view
            statusContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            statusContainerView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            statusContainerView.heightAnchor.constraint(equalToConstant: ViewSizeConstants.CHARACTER_LIST_CONTENT_VIEW_STATUS_CONTAINER_VIEW_SIZE.height),
            statusContainerView.widthAnchor.constraint(equalToConstant: ViewSizeConstants.CHARACTER_LIST_CONTENT_VIEW_STATUS_CONTAINER_VIEW_SIZE.width),
            
            /// Set constraints to position the label stack view
            labelStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            labelStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            labelStackView.trailingAnchor.constraint(equalTo: statusContainerView.leadingAnchor, constant: -8),
            labelStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
}
