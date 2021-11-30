//
//  NetworkSession.swift
//  
//
//  Created by Anthony Soulier on 30/11/2021.
//

import Foundation

public protocol NetworkSession {
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

public extension NetworkSession {
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await data(for: request, delegate: nil)
    }
}

extension URLSession: NetworkSession {
    
}
