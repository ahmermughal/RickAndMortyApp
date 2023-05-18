//
//  CharacterListVC.swift
//  RickAndMortyApp
//
//  Created by Ahmer Akhter on 18/05/2023.
//

import UIKit
import Combine

enum Section{
    case main
}

class CharacterListVC: BaseViewController {

    // MARK: Variables
    /// Create an instance of CharacterListContentView as the view for this view controller
    private let contentView = CharacterListContentView()
    
    /// An array to hold subscriptions to publishers
    private var subscriptions: [AnyCancellable] = []
    
    /// The view model responsible for managing character data
    private let viewModel: CharacterViewModel
    
    /// The diffable data source for the table view
    private var dataSource: UITableViewDiffableDataSource<Section, CharacterProfile>!
    
    // MARK: Init Functions
    /// Initialize the view controller with a character view model
    init(viewModel: CharacterViewModel = CharacterViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Override Functions
    /// Loads the content view as the parent view of the view controller
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Set up bindings between the view model and view controller
        setupBinding()
        
        /// Configure the view controller
        configureVC()
        
        /// Configure the table view
        configureTableView()
        
        /// Configure the data source
        configureDataSource()
        
        /// Request character data from the view model
        viewModel.getCharacters()
    }
    
    // MARK: Private Functions
    /// Configure the view controller
    private func configureVC() {
        /// Set the title of the view controller
        title = StringConstants.CHARACTER_LIST
        
        /// Enable large titles for the navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    /// Configure the table view
    private func configureTableView() {
        /// Register the character table view cell class
        contentView.tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.REUSE_ID)
        
        /// Hide the separators between table view cells
        contentView.tableView.separatorStyle = .none
        
        /// Set the table view delegate to self
        contentView.tableView.delegate = self
    }
    
    /// Set up bindings between the view model and view controller
    private func setupBinding() {
        viewModel.$characterList
            .filter({ list in
                /// Filter out empty character lists
                !list.isEmpty
            })
            .sink(receiveValue: handleCharacterList)
            .store(in: &subscriptions)
        
        viewModel.$showLoader
            /// Filter out nil values
            .compactMap{$0}
            .sink(receiveValue: handleShowLoader)
            .store(in: &subscriptions)
        
    }

    /// Handle the received character list from the view model
    private func handleCharacterList(characters: [CharacterProfile]) {
        /// Update the table view data with the received characters
        updateData(on: characters)
    }
    
    /// Handle the showLoader variable from the view model to hide or show loading
    private func handleShowLoader(show: Bool){
        if show{
            showLoadingView()
        }else{
            dismissLoadingView()
        }
    }
    
    /// Configure the data source for the table view
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: contentView.tableView, cellProvider: { tableView, indexPath, character in
            let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.REUSE_ID, for: indexPath) as! CharacterTableViewCell
            
            /// Set the character data for the cell
            cell.set(character: character)
            
            return cell
        })
    }
    
    
    /// Update the data of the diffable data source
    private func updateData(on characters: [CharacterProfile]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CharacterProfile>()
        
        /// Append the main section and its items to the snapshot
        snapshot.appendSections([.main])
        snapshot.appendItems(characters)
        
        /// Apply the snapshot to the data source on the main queue
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
// MARK: UITableViewDelegate
extension CharacterListVC: UITableViewDelegate {
    
    /// Delegate method called when the user finishes dragging the scroll view
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        /// Check if the user has scrolled to the bottom of the list
        if offsetY > contentHeight - height {
            
            /// Check if there are more characters to load and if the loading of next characters is not already in progress
            guard viewModel.hasNext, !viewModel.isLoadingNext else {
                return
            }
            
            /// Request the next set of characters from the view model
            viewModel.getCharacters()
        }
    }
}

