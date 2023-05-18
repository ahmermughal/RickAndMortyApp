//
//  NetworkTests.swift
//  RickAndMortyAppTests
//
//  Created by Ahmer Akhter on 18/05/2023.
//

import XCTest
import Combine
@testable import RickAndMortyApp

final class NetworkTests: XCTestCase {

    var subscriptions = Set<AnyCancellable>()

    override class func setUp() {
        
    }

    override class func tearDown() {
        
    }
    
    /// This is a test function for the `performRequest` function of the `NetworkService` class. It tests whether the function can successfully parse data from a network request with a valid response. Here's a breakdown of the different sections:
    /// - GIVEN: This section sets up the required components for the test. It initializes a mock URLSession object and sets up a mock HTTPURLResponse object. It also sets up an expectation to wait for a response from the network request.
    /// - WHEN: This section sets up the input for the performRequest function. It initializes a `NetworkService` object with the mock URLSession object and sets up the mock data to be returned by the MockURLProtocol. It then starts the network request using the performRequest function.
    /// - THEN: This section checks the output of the performRequest function. It checks whether the returned item is an array containing 20 character profile items. If the expectation is met, the test passes.
    func testPerformRequest_WhenValidDataProvided_ShouldParseDataSuccessfully(){
    
        // GIVEN
        /// Setup `URLSessionConfiguration` to ephemeral so that no caching is done
        let config = URLSessionConfiguration.ephemeral
        /// protocolClasses of the configuration is set to our `MockURLProtocol` so we can mock Network requests
        config.protocolClasses = [MockURLProtocol.self]
        /// `URLSession` is initalized using our mock configuration
        let urlSession = URLSession(configuration: config)
        
        // WHEN
        /// parse locally stored `ValidData` json to a mock data object
        let jsonData = getData(name: "ValidData")
        /// mock data object is passed to our `MockURLProtocol`
        MockURLProtocol.mockData = jsonData
        /// mock `HTTPURLResponse` is setup with a status code of 200
        MockURLProtocol.mockHTTPResponse = HTTPURLResponse(url: URL(string: "https://www.google.com/")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        /// `NetworkService` object is intilized with a mock URLSession object
        let netService = NetworkService(urlSession: urlSession)
        
        /// expectation is setup to wait for response from a network request
        let expectation = self.expectation(description: "Network")
        
        ///  Network request is started using the performRequest function of  get all characters
        netService.performRequest(apiType: .getAllCharacters(page: 1), resultType: CharacterResponse.self)
            /// the stream from the network request is obsevered with sink
            .sink { result in
                switch result {
                case .finished:
                    break
                case .failure(_):
                    break
                }
            }
            receiveValue: { item in
                // THEN
                /// when data is successfully parsed then should return correct then item should be an array containing 20 `CharcterProfile` item
                XCTAssertEqual(item.results.count, 20)
                /// expection is meet which will pass the XCTest
                expectation.fulfill()
            }
            /// the subscription is stored in the subscriptions property.
            .store(in: &subscriptions)

        /// the test waits with a timeout of 5 seconds before failing
        self.wait(for: [expectation], timeout: 5)
        
    }
    
    /// This is a unit test function tests the behavior of the `performRequest` method of the `NetworkService` class when invalid data is provided. Here is a breakdown of the different parts of the code:
    /// - GIVEN: sets up the necessary environment for the test. It creates a URLSession object with an ephemeral configuration and sets the protocolClasses property to a custom class `MockURLProtocol`, which allows us to mock network requests. It also sets up the mock data and mock HTTP response that will be returned by the `MockURLProtocol` class. Finally, it creates an instance of the `NetworkService` class with the mocked URLSession.
    /// - WHEN: sets up the parameters for the performRequest method and starts the network request by calling sink on the result of the method call. The sink closure will be called when the network request completes, either successfully or with an error.
    /// - THEN:  contains the assertions that will be used to verify the behavior of the performRequest method. In this case, we expect the result to be a failure with an error of type dataParseError.
    func testPerformRequest_WhenInvalidDataProvided_ShouldThrowDataParseError(){
    
        // GIVEN
        /// Setup `URLSessionConfiguration` to ephemeral so that no caching is done
        let config = URLSessionConfiguration.ephemeral
        /// protocolClasses of the configuration is set to our `MockURLProtocol` so we can mock Network requests
        config.protocolClasses = [MockURLProtocol.self]
        /// `URLSession` is initalized using our mock configuration
        let urlSession = URLSession(configuration: config)
        
        // WHEN
        /// parse locally stored `InvalidData` json to a mock data object
        let jsonData = getData(name: "InvalidData")
        /// mock data object is passed to our `MockURLProtocol`
        MockURLProtocol.mockData = jsonData
        /// mock `HTTPURLResponse` is setup with a status code of 200
        MockURLProtocol.mockHTTPResponse = HTTPURLResponse(url: URL(string: "https://www.google.com/")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        /// `NetworkService` object is intilized with a mock URLSession object
        let netService = NetworkService(urlSession: urlSession)
        
        /// expectation is setup to wait for response from a network request
        let expectation = self.expectation(description: "Network")
        
        ///  Network request is started using the performRequest function of get all characters
        netService.performRequest(apiType: .getAllCharacters(page: 1), resultType: CharacterResponse.self)
            /// the stream from the network request is obsevered with sink
            .sink { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    // THEN
                    /// Invalid data was passed so the expected error should be `dataParseError`
                    XCTAssertEqual(error, .dataParseError)
                    /// expection is meet which will pass the XCTest
                    expectation.fulfill()
                }
            }
            receiveValue: { _ in
            }
            /// the subscription is stored in the subscriptions property.
            .store(in: &subscriptions)
        
        /// the test waits with a timeout of 5 seconds before failing
        self.wait(for: [expectation], timeout: 5)
        
    }

    
    /// This is a test function for the `performRequest` function of the `NetworkService` class. The purpose of the test is to ensure that when a server responds with a 404 error, the badRequest error is thrown. Here's a breakdown of the different sections:
    /// - GIVEN: This section sets up the required components for the test. It initializes a mock URLSession object and sets up a mock HTTPURLResponse object. It also sets up an expectation to wait for a response from the network request.
    /// - WHEN: This section sets up the input for the performRequest function. It initializes a `NetworkService` object with the mock URLSession object and sets up the mock response of 404 to be returned by the `MockURLProtocol`. It then starts the network request using the performRequest function.
    /// - THEN: contains the assertions that will be used to verify the behavior of the performRequest method. In this case, we expect the result to be a failure with an error of type badRequest.
    func testPerformRequest_WhenServerResponse404_ShouldThrowBadRequest(){
    
        // GIVEN
        /// Setup `URLSessionConfiguration` to ephemeral so that no caching is done
        let config = URLSessionConfiguration.ephemeral
        /// protocolClasses of the configuration is set to our `MockURLProtocol` so we can mock Network requests
        config.protocolClasses = [MockURLProtocol.self]
        /// `URLSession` is initalized using our mock configuration
        let urlSession = URLSession(configuration: config)

        
        // WHEN
        /// mock `HTTPURLResponse` is setup with a status code of 404
        let responseCode = 404
        MockURLProtocol.mockHTTPResponse = HTTPURLResponse(url: URL(string: "https://www.google.com/")!, statusCode: responseCode, httpVersion: nil, headerFields: nil)

        
        /// `NetworkService` object is intilized with a mock URLSession object
        let netService = NetworkService(urlSession: urlSession)
        
        /// expectation is setup to wait for response from a network request
        let expectation = self.expectation(description: "Network")
        
        ///  Network request is started using the performRequest function of get all characters
        netService.performRequest(apiType: .getAllCharacters(page: 1), resultType: CharacterResponse.self)
            /// the stream from the network request is obsevered with sink
            .sink { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    // THEN
                    /// 404 response was passed so the expected error should be `badRequest`
                    XCTAssertEqual(error, .badRequest)
                    expectation.fulfill()
                }
                
            }
            receiveValue: { _ in
            }
            /// The subscription is stored in the subscriptions property.
            .store(in: &subscriptions)
        /// the test waits with a timeout of 5 seconds before failing
        self.wait(for: [expectation], timeout: 5)
        
    }
    
    
    func getData(name : String)->Data{

       let bundle =  Bundle(for: type(of: self)).url(forResource: name, withExtension: "json")!
        return try! Data(contentsOf: bundle)
    }
    
}

