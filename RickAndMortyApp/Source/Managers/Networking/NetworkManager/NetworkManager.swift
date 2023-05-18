//
//  NetworkManager.swift
//  RickAndMortyApp
//
//  Created by Ahmer Akhter on 18/05/2023.
//

import Foundation
import Combine

/// The code defines a class named `NetworkManager`. It contains two functions, `getAllCharacters`.
///
/// - The `getAllCharacters` function that is used to query all the characters in Rick And Morty tv show characters.
/// "AnyPublisher<CharacterResponse, NetworkError>", meaning it returns an CharacterResponse objects or a "NetworkError". The function performs a network request using the "performRequest" function from the "NetworkService" class and passes in the API type "getAllCharacters".
///
class NetworkManager : NetworkManagerProtocol{
    
    static let shared = NetworkManager()
    
    private let networkService = NetworkService()
    private init() {}
    
    /// Define a function `getAllCharacters` that is used to query all the characters in Rick And Morty tv show characters.
    /// It returns an "AnyPublisher" object containing an array of "CharacterResponse" elements or a "NetworkError" object
    /// - Returns: AnyPublisher of CharacterResponse or NetworkError
    /// - Parameter page: current page number used for pagination
    func getAllCharacters(page: Int = 1) -> AnyPublisher<CharacterResponse, NetworkError>{
        /// Return the result of the performRequest function, with the apiType being set to "getAllCharacters" and the "page"
        /// parameter as an argument
        return networkService.performRequest(apiType: .getAllCharacters(page: page), resultType: CharacterResponse.self)
    }

    
}
