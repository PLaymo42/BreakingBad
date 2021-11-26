//
//  URLResponse+Extension.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation

extension URLResponse {
    func throwOnFailureStatusCode() throws {
        if let urlReponse = self as? HTTPURLResponse {
            if (200...300).contains(urlReponse.statusCode) == false {
                throw BreakingBadError.httpError
            }
        }
    }
}
