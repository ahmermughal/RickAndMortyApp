//
//  NetworkError.swift
//  RickAndMortyApp
//
//  Created by Ahmer Akhter on 18/05/2023.
//

import Foundation


enum NetworkError: Swift.Error {
    case someError
    case noInternet
    case invalidURL
    case badRequest
    case dataParseError
    case invalidData
    case unableToRefreshToken
}
