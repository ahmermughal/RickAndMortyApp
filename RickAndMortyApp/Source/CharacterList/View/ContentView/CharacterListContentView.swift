//
//  CharacterListContentView.swift
//  RickAndMortyApp
//
//  Created by Ahmer Akhter on 18/05/2023.
//

import UIKit

class CharacterListContentView: UIView {

    // MARK: UI Elements
    /// Create a UITableView
    let tableView = UITableView()
    
    // MARK: Init Functions
    /// Initialize the view
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        /// Setup the view
        setupView()
        
        /// Setup the table view
        setupTableView()
        
        /// Layout the UI elements
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Private Functions
    /// Setup the view
    private func setupView() {
        /// Additional view setup can be done here if needed
    }
    
    /// Setup the table view
    private func setupTableView() {
        /// Set the background color of the table view to clear
        tableView.backgroundColor = .clear
    }
    
    /// Layout the UI elements
    private func layoutUI() {
        let views = [tableView]
        
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            /// Set constraints to position the table view to cover the entire safe area of the view
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
