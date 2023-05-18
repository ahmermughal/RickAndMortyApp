//
//  NetworkRouter.swift
//  RickAndMortyApp
//
//  Created by Ahmer Akhter on 18/05/2023.
//

import Foundation

/// Defines an enumeration named `NetworkRouter`" with a case: `getAllCharacte`, This enumeration is used to handle different API routes in a network layer of an application.
/// Each case defines different properties like "path", "method", "parameters", "bodyData",  that are used to build a complete API request. The "baseURL" property is used as the base URL for building APIs, while "path" defines the endpoint of the API based on the current case. "method" defines the type of HTTP method (e.g., GET, PATCH) used for each case. "parameters" defines the parameters required for each endpoint, and "bodyData" defines the body data that an API will have. 
enum NetworkRouter{

    case getAllCharacters(page: Int)

    
    // MARK: Base URL
    static let baseURL: String = "https://rickandmortyapi.com/"

    // MARK: Path
    /// Defines the end point of an API based on the current enum case
    var path: String {
        switch self {
        case .getAllCharacters:
            return "api/character"
        }

    }
    
    
    /// Enumeration to represent different HTTP methods.
    private enum MethodType : String{
        
        /// The GET method is used to retrieve data from a server.
        case get = "GET"
        
        /// The PATCH method is used to make partial updates to a resource on a server.
        case patch = "PATCH"
        
        /// The POST method is used to submit data to a server for processing.
        case post = "POST"
        
        /// The UPDATE method is not a standard HTTP method. This case may be a typo or an unsupported custom method.
        case update = "UPDATE"
    }
    
    // MARK: - HTTPMethod
    /// Defines the methods type based on the current enum case
    var method: String {
        switch self {
        case .getAllCharacters:
            return MethodType.get.rawValue

        }
    }
    
    
    // MARK: - Parameters
    /// Defines parameters an endpoint takes based on the current enum case.
    var parameters: [String: Any]? {
        switch self {
        case .getAllCharacters(let page):
            return ["page" : "\(page)"]
        }
    }
    
    
    // MARK: - BodyData
    /// Defines the body data an API will have and encodes the given model passed in the case parameter to Data
    var bodyData: Data?{
        switch self{
        case .getAllCharacters:
            return nil
        }
    }
    
}
