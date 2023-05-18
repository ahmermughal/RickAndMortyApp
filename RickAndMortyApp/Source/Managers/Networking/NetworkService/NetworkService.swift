//
//  NetworkService.swift
//  RickAndMortyApp
//
//  Created by Ahmer Akhter on 18/05/2023.
//

import Foundation


import Foundation
import Combine

/// NetworkService contains a single generic function named "performRequest". The function performs a network request based on the provided NetworkRouter type, and returns a publisher of the specified Decodable type T. The function first creates a URL from the baseURL and path properties of the NetworkRouter, adds parameters, sets the HTTP method and body, and adds headers to the request.
/// The request is made using a shared URLSession and the response is decoded as the specified T type. Any errors that occur during the request or decoding process are mapped to NetworkError and returned as a publisher. The publisher is of type "AnyPublisher<T, NetworkError>" and is executed on the main dispatch queue.
class NetworkService : NetworkServiceProtocol{
    
    
    let urlSession : URLSession
    init(urlSession : URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    /// This generic function performs a network request based on the provided NetworkRouter type. It creates a URL from the baseURL and path properties in the NetworkRouter, adds any specified parameters, sets the HTTP method and body, and adds headers to the request. The URL request is then made using a shared URLSession and the response is decoded as the specified. Decodable type T. Any errors during the request or decoding process are mapped to NetworkError and returned as a publisher. The publisher is of type AnyPublisher<T, NetworkError> and is executed on the main dispatch queue.
    ///
    /// - Parameter apiType: API endpoint type
    /// - Returns: A publisher of the Generic decodable object
    func performRequest<T:Decodable>(apiType: NetworkRouter, resultType: T.Type) -> AnyPublisher<T, NetworkError> {
        
        /// create baseURL from the baseURL string specified in the NetworkRouter protocol
        guard let baseURL = URL(string: NetworkRouter.baseURL) else {
            
            /// return a Fail publisher with the invalidURL error if the baseURL string is invalid
            return Fail(error: .invalidURL)
                .eraseToAnyPublisher()
        }
        
        /// create fullURL by appending the path from the apiType case of the NetworkRouter enum to the baseURL
        let fullURL = baseURL.appendingPathComponent(apiType.path)
        
        /// create a URLComponents object from the fullURL
        guard var urlComponent = URLComponents(url: fullURL, resolvingAgainstBaseURL: true) else {
            /// return a Fail publisher with the invalidURL error if the fullURL is invalid
            return Fail(error: .invalidURL)
                .eraseToAnyPublisher()
            
        }
        
        /// initialize an empty array for URLQueryItems
        var queryItems : [URLQueryItem] = []
        
        /// if there are parameters for the apiType case of the NetworkRouter enum
        if let params = apiType.parameters {
            /// iterate over each parameter
            for item in params{
                /// add a URLQueryItem with the parameter key and value as a string to the queryItems array
                queryItems.append(URLQueryItem(name: item.key, value: item.value as? String))
            }
        }
        
        /// Assign the array of query items to the queryItems property of the URLComponents object
        urlComponent.queryItems = queryItems
        
        /// Create a URL object from the URLComponents object
        guard let url = urlComponent.url else {
            /// If the URL object can't be created, return a failed publisher with an invalid URL error
            return Fail(error: .invalidURL)
                .eraseToAnyPublisher()
        }
        
        /// Create a URLRequest object with the URL
        var urlRequest = URLRequest(url: url)
        
        /// Set the HTTP method of the request to the method specified in the NetworkRouter
        urlRequest.httpMethod = apiType.method
        print("HTTPMethod Type: \(apiType.method)")
        /// Set the HTTP body of the request to the data specified in the Network Router
        urlRequest.httpBody = apiType.bodyData
        print("HTTPMethod Body: \(apiType.bodyData)")
        
        
        debugPrint("Request URL: \(urlRequest.url)")
        /// Use the shared URLSession to create a dataTaskPublisher with the URLRequest
        return  urlSession
            .dataTaskPublisher(for: urlRequest)
        /// Try to map the data and response from the network request to Data
            .tryMap { (data: Data, response: URLResponse) -> Data in
                /// Ensure the response is an HTTPURLResponse with a status code of 200
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    /// If the response is not valid, throw an invalid URL error
                    throw NetworkError.badRequest
                }
                
                /// Return the received data
                return data
            }
            .handleEvents(receiveOutput:{ data in
                //debugPrint("URL Data: \(String(decoding: data, as: UTF8.self))")
            })
        /// Decode the received data as the specified Decodable type T
            .decode(type: T.self, decoder: JSONDecoder())
        /// Map any errors that occur to a NetworkError
            .mapError { error -> NetworkError in
                
                if error.localizedDescription == "The Internet connection appears to be offline."{
                    return .noInternet
                }
                
                switch error {
                case is URLError:
                    /// If the error is a URLError, return an invalid URL error
                    return .invalidURL
                case is DecodingError:
                    /// If the error is a DecodingError, return a data parse error
                    return .dataParseError
                default:
                    /// If the error is of any other type, return it as a NetworkError or return a general error if it can't be cast
                    return error as? NetworkError ?? .someError
                }
            }
            .receive(on: DispatchQueue.main)
        /// Erase the type of the publisher to AnyPublisher
            .eraseToAnyPublisher()
    }
    
}
