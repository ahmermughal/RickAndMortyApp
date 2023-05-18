//
//  CharacterListViewModel.swift
//  RickAndMortyApp
//
//  Created by Ahmer Akhter on 18/05/2023.
//

import Foundation
import Combine

class CharacterViewModel {
    
    // MARK: Publishers
    /// Published property to hold the character list
    @Published private(set) var characterList: [CharacterProfile] = []
    
    // MARK: Variables
    /// An array to hold subscriptions to publishers
    private var subscriptions: [AnyCancellable] = []
    
    /// The current page of characters being fetched
    private var currentPage: Int = 1
    
    /// Flag to indicate if there are more characters to fetch
    private(set) var hasNext = false
    
    /// Flag to indicate if loading of next characters is in progress
    private(set) var isLoadingNext = false
    
    // MARK: Public Functions
    /// Method to fetch characters from the network
    func getCharacters() {
        isLoadingNext = true
        
        /// Call the network manager to get all characters for the current page
        NetworkManager.shared.getAllCharacters(page: currentPage)
            .sink(receiveCompletion: handleCompletion, receiveValue: handleCharacterResponse)
            .store(in: &subscriptions)
    }
    
    // MARK: Private Functions
    /// Handle the completion of the network request
    private func handleCompletion(completion: Subscribers.Completion<NetworkError>) {
        isLoadingNext = false
        print(completion)
    }
    
    /// Handle the response of the character request
    private func handleCharacterResponse(response: CharacterResponse) {
        /// Append the received characters to the existing character list
        characterList.append(contentsOf: response.results)
        
        /// Check if there is a next page available and update the current page and hasNext flag accordingly
        if let safeNextPage = response.info.nextPage, !safeNextPage.isEmpty {
            currentPage += 1
            hasNext = true
        } else {
            hasNext = false
        }
    }
}

