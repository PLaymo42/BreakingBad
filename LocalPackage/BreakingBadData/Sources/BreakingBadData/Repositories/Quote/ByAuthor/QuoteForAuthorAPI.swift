//
//  QuoteForAuthorAPI.swift
//  
//
//  Created by Anthony Soulier on 29/11/2021.
//

import Foundation

struct QuoteForAuthorAPI: API {

    var author: String

    func build() -> URLRequest? {

        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "www.breakingbadapi.com"
        urlComponent.path = "/api/quote"

        urlComponent.queryItems = [
            URLQueryItem(name: "author", value: author.replacingOccurrences(of: " ", with: "+"))
        ]

        return urlComponent.url.flatMap { URLRequest(url: $0) }
    }
}
