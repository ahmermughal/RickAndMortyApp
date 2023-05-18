//
//  CharacterListVC.swift
//  RickAndMortyApp
//
//  Created by Ahmer Akhter on 18/05/2023.
//

import UIKit

class CharacterListVC: UIViewController {

    private let contentView = CharacterListContentView()
    
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
    }
    
    
    private func configureVC(){
        title = StringConstants.CHARACTER_LIST
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func configureTableView(){
        contentView.tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.REUSE_ID)
        contentView.tableView.dataSource = self
        contentView.tableView.separatorStyle = .none
    }


}

extension CharacterListVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.REUSE_ID) as! CharacterTableViewCell
        
        cell.set(character: CharacterProfile(name: "Rick", species: "Human", status: "Alive", imageURL: ""))
        
        return cell
    }
    
    
    
    
}
