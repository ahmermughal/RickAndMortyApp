//
//  MockURLProtocol.swift
//  RickAndMortyAppTests
//
//  Created by Ahmer Akhter on 18/05/2023.
//

import Foundation

class MockURLProtocol : URLProtocol{
    
    static var mockData : Data?
    static var mockHTTPResponse : HTTPURLResponse?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        if let mockHTTPResponse = MockURLProtocol.mockHTTPResponse{
            self.client?.urlProtocol(self, didReceive: mockHTTPResponse, cacheStoragePolicy: .notAllowed)
        }

        
        if let mockData = MockURLProtocol.mockData{
            self.client?.urlProtocol(self, didLoad: mockData)
        }
        
        
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    
    override func stopLoading() {
        
    }
}
