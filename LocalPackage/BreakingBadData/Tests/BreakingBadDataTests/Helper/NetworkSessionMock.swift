//
//  URLSessionMock.swift
//  
//
//  Created by Anthony Soulier on 30/11/2021.
//

import Foundation
import BreakingBadData

class NetworkSessionMock: NetworkSession {

    var data: Data
    var response: URLResponse

    init(data: Data, response: URLResponse) {
        self.data = data
        self.response = response
    }

    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        return (data, response)
    }

}
