//
//  RandomQuoteRepository.swift
//  
//
//  Created by Anthony Soulier on 28/11/2021.
//

import Foundation

public protocol QuoteForAuthorRepository {
    func get(forAuthor author: String) async throws -> [Quote]
}

public struct QuoteForAuthorRepositoryImp: QuoteForAuthorRepository {

    private let urlSession: NetworkSession
    private let decoder: JSONDecoder

    public init(urlSession: NetworkSession,
                decoder: JSONDecoder) {
        self.urlSession = urlSession
        self.decoder = decoder
    }

    public func get(forAuthor author: String) async throws -> [Quote] {
        let api = QuoteForAuthorAPI(author: author)
        guard let urlRequest = api.build() else { throw BreakingBadError.malformedAPI }

        let (data, response) = try await urlSession.data(for: urlRequest)
        try response.throwOnFailureStatusCode()
        return try decoder.decode([Quote].self, from: data)
    }
}
