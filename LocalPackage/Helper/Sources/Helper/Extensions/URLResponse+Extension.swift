//
//  URLResponse+Extension.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation

public struct StatusCodeError: Error {
    public var code: Int
    public var response: URLResponse
}

public extension URLResponse {
    func throwOnFailureStatusCode() throws {
        if let urlReponse = self as? HTTPURLResponse {
            if (200...300).contains(urlReponse.statusCode) == false {
                throw StatusCodeError(code: urlReponse.statusCode, response: urlReponse)
            }
        }
    }
}
