//
//  NetworkManagerProtocol.swift
//  RickAndMortyApp
//
//  Created by Ahmer Akhter on 18/05/2023.
//

import Foundation


import Foundation
import Combine




/// This protocol is used to act as a blueprint for the class or struct that implements it.
/// It allows to write easily testable code as we can now mock the network manager using this protocol
protocol NetworkManagerProtocol{
    
    /// Method signature for `getAllCharacters`.
    /// - Returns: an AnyPublisher of an array of CharacterResponse objects, and may produce a NetworkError.
    func getAllCharacters() -> AnyPublisher<CharacterResponse, NetworkError>


  
}
