//
//  RandomQuoteRepository.swift
//  
//
//  Created by Anthony Soulier on 28/11/2021.
//

import Foundation

public protocol RandomQuoteRepository {
    func get() async throws -> Quote?
}

public struct RandomQuoteRepositoryImp: RandomQuoteRepository {

    private let urlSession: NetworkSession
    private let decoder: JSONDecoder

    public init(urlSession: NetworkSession,
                decoder: JSONDecoder) {
        self.urlSession = urlSession
        self.decoder = decoder
    }

    public func get() async throws -> Quote? {

        let api = RandomQuoteAPI()
        guard let urlRequest = api.build() else { throw BreakingBadError.malformedAPI }

        let (data, response) = try await urlSession.data(for: urlRequest)
        try response.throwOnFailureStatusCode()
        let decoded = try decoder.decode([Quote].self, from: data)
        return decoded.first
    }
}
