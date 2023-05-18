//
//  CharacterListViewModel.swift
//  RickAndMortyApp
//
//  Created by Ahmer Akhter on 18/05/2023.
//

import Foundation
import Combine

class CharacterViewModel{
    
    private var subscriptions : [AnyCancellable] = []
    @Published private(set) var characterList : [CharacterProfile] = []
    
    init() {
        
    }
    
    func getCharacters(){
        NetworkManager.shared.getAllCharacters()
            .sink(receiveCompletion: handleCompletion, receiveValue: handleCharacterResponse)
            .store(in: &subscriptions)
    }
    
    private func handleCompletion(completion: Subscribers.Completion<NetworkError>){
        print(completion)
    }
    
    private func handleCharacterResponse(response: CharacterResponse){
        print(response)
        
    }
    
    
}
