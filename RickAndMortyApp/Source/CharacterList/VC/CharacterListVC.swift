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

class CharacterListVC: UIViewController {

    
    private let contentView = CharacterListContentView()
    private var subscriptions : [AnyCancellable] = []
    private let viewModel : CharacterViewModel
    private var dataSource: UITableViewDiffableDataSource<Section, CharacterProfile>!

    init(viewModel: CharacterViewModel = CharacterViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        configureVC()
        configureTableView()
        configureDataSource()
        viewModel.getCharacters()
    }
    
    
    private func configureVC(){
        title = StringConstants.CHARACTER_LIST
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func configureTableView(){
        contentView.tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.REUSE_ID)
        contentView.tableView.separatorStyle = .none
    }
    
    private func setupBinding(){
        viewModel.$characterList
            .filter({ list in
                !list.isEmpty
            })
            .sink(receiveValue: handleCharacterList)
            .store(in: &subscriptions)
    }

    private func handleCharacterList(characters: [CharacterProfile]){
           updateData(on: characters)
    }
    
    private func configureDataSource(){
        dataSource = UITableViewDiffableDataSource(tableView: contentView.tableView, cellProvider: { tableView, indexPath, character in
            let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.REUSE_ID, for: indexPath) as! CharacterTableViewCell
            
            cell.set(character: character)
            
            return cell
        })
        
    }
    
    func updateData(on characters: [CharacterProfile]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, CharacterProfile>()
        snapshot.appendSections([.main])
        snapshot.appendItems(characters)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }

}
