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
    }
    
    
    private func configureVC(){
        title = StringConstants.CHARACTER_LIST
        navigationController?.navigationBar.prefersLargeTitles = true
    }


}
