//
//  CharacterListViewModel.swift
//  RickAndMortyApp
//
//  Created by Ahmer Akhter on 18/05/2023.
//

import Foundation
import Combine

class CharacterViewModel{
    
    @Published private(set) var characterList : [CharacterProfile] = []
    
    private var subscriptions : [AnyCancellable] = []
    private var currentPage : Int = 1
    private(set) var hasNext = false
    private(set) var isLoadingNext = false
    
    func getCharacters(){
        isLoadingNext = true
        NetworkManager.shared.getAllCharacters(page: currentPage)
            .sink(receiveCompletion: handleCompletion, receiveValue: handleCharacterResponse)
            .store(in: &subscriptions)
    }
    
    private func handleCompletion(completion: Subscribers.Completion<NetworkError>){
        isLoadingNext = false
        print(completion)
    }
    
    private func handleCharacterResponse(response: CharacterResponse){
        
        characterList.append(contentsOf: response.results)
        
        if let safeNextPage = response.info.nextPage, !safeNextPage.isEmpty{
            currentPage += 1
            hasNext = true
        }else{
            hasNext = false
        }
    }
    
    
}
