//
//  RandomQuoteRepository.swift
//  
//
//  Created by Anthony Soulier on 28/11/2021.
//

import Foundation

public protocol RandomQuoteRepository {
    associatedtype OUT
    func get(decoder: JSONDecoder) async throws -> OUT?
}

public struct RandomQuoteRepositoryImp<M: Mapper>: RandomQuoteRepository where M.IN == Quote {

    private let api: RandomQuoteAPI
    private let mapper: M
    private let urlSession: NetworkSession

    public init(api: RandomQuoteAPI,
                urlSession: NetworkSession,
                mapper: M) {
        self.mapper = mapper
        self.urlSession = urlSession
        self.api = api
    }

    public func get(decoder: JSONDecoder) async throws -> M.OUT? {

        guard let urlRequest = api.build() else { throw BreakingBadError.malformedAPI }

        let (data, response) = try await urlSession.data(for: urlRequest)
        try response.throwOnFailureStatusCode()
        let decoded = try decoder.decode([M.IN].self, from: data)
        return decoded.first.map { mapper.map(from: $0) }
    }
}
