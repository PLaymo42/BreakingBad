//
//  RandomQuoteAPI.swift
//  
//
//  Created by Anthony Soulier on 28/11/2021.
//

import Foundation

public struct RandomQuoteAPI: API {

    public init() {}

    public func build() -> URLRequest? {
        URLRequest(url: URL(string: "https://www.breakingbadapi.com/api/quote/random")!)
    }
}
