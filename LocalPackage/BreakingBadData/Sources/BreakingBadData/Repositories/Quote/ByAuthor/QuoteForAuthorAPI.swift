//
//  QuoteForAuthorAPI.swift
//  
//
//  Created by Anthony Soulier on 29/11/2021.
//

import Foundation

public struct QuoteForAuthorAPI: API {

    public init() { }

    private var author: String?

    mutating func setAuthor(_ author: String) {
        self.author = author
    }

    func build() -> URLRequest? {

        guard let author = author else {
            return nil
        }

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
