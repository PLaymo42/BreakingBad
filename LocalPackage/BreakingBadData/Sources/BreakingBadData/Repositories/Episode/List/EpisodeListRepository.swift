//
//  CharacterListRepository.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation
import Helper

public protocol EpisodeListRepository {
    associatedtype OUT
    func get(serie: EpisodeListAPI.Serie, decoder: JSONDecoder) async throws -> [OUT]
}

public struct EpisodeListRepositoryImp<M: Mapper>: EpisodeListRepository where M.IN == Episode {
    
    private let api: EpisodeListAPI
    private let mapper: M
    private let urlSession: NetworkSession

    public init(api: EpisodeListAPI,
         urlSession: NetworkSession,
         mapper: M) {
        self.mapper = mapper
        self.urlSession = urlSession
        self.api = api
    }

    public func get(serie: EpisodeListAPI.Serie, decoder: JSONDecoder) async throws -> [M.OUT] {

        var api = api
        api.setSerie(serie)
        guard let urlRequest = api.build() else {
            throw BreakingBadError.malformedAPI
        }


        let (data, response) = try await urlSession.data(for: urlRequest)
        try response.throwOnFailureStatusCode()
        let decoded = try decoder.decode([M.IN].self, from: data)
        return decoded.map { mapper.map(from: $0) }
    }
}
