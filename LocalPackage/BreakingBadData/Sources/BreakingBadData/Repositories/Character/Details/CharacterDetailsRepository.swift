//
//  CharacterListRepository.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation
import Helper

public protocol CharacterDetailsRepository {
    associatedtype OUT
    func get(id: Int, decoder: JSONDecoder) async throws -> OUT?
}

public struct CharacterDetailsRepositoryImp<M: Mapper>: CharacterDetailsRepository where M.IN == Character {
    
    private let api: CharacterDetailsAPI
    private let mapper: M
    private let urlSession: NetworkSession

    public init(api: CharacterDetailsAPI,
                urlSession: NetworkSession,
                mapper: M) {
        self.mapper = mapper
        self.urlSession = urlSession
        self.api = api
    }

    public func get(id: Int, decoder: JSONDecoder) async throws -> M.OUT? {
        var api = api
        api.setCharacterID(id)
        guard let urlRequest = api.build() else { throw BreakingBadError.malformedAPI }

        let (data, response) = try await urlSession.data(for: urlRequest)
        try response.throwOnFailureStatusCode()
        let decoded = try decoder.decode([M.IN].self, from: data)
        return decoded.first.flatMap { mapper.map(from: $0) }
    }
}
