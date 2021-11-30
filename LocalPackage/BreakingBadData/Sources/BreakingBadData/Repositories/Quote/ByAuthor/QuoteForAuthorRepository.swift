//
//  RandomQuoteRepository.swift
//  
//
//  Created by Anthony Soulier on 28/11/2021.
//

import Foundation

public protocol QuoteForAuthorRepository {
    associatedtype OUT
    func get(forAuthor author: String, decoder: JSONDecoder) async throws -> [OUT]
}

public struct QuoteForAuthorRepositoryImp<M: Mapper>: QuoteForAuthorRepository where M.IN == Quote {

    private let api: QuoteForAuthorAPI
    private let mapper: M
    private let urlSession: NetworkSession

    public init(api: QuoteForAuthorAPI,
                urlSession: NetworkSession,
                mapper: M) {
        self.mapper = mapper
        self.urlSession = urlSession
        self.api = api
    }

    public func get(forAuthor author: String, decoder: JSONDecoder) async throws -> [M.OUT] {
        var api = api
        api.setAuthor(author)
        guard let urlRequest = api.build() else { throw BreakingBadError.malformedAPI }

        let (data, response) = try await urlSession.data(for: urlRequest)
        try response.throwOnFailureStatusCode()
        let decoded = try decoder.decode([M.IN].self, from: data)
        return decoded.map { mapper.map(from: $0) }
    }
}
