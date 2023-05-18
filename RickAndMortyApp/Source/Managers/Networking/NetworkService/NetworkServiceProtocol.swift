//
//  NetworkServiceProtocol.swift
//  RickAndMortyApp
//
//  Created by Ahmer Akhter on 18/05/2023.
//

import Foundation
import Combine
/// This protocol is used to act as a blueprint for the class or struct that implements it.
/// It would make sure that the class or struct implements performRequest function along with its defination
protocol NetworkServiceProtocol{
    
    /// Method signature for performRequest. This method takes a NetworkRouter type and returns an
    /// AnyPublisher of generic type T that conforms to the Decodable protocol, and may produce a NetworkError.
    func performRequest<T:Decodable>(apiType: NetworkRouter, resultType: T.Type) -> AnyPublisher<T, NetworkError>
    
    
}
