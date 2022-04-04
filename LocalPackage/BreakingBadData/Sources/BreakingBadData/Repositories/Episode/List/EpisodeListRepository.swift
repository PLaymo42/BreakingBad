//
//  CharacterListRepository.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation
import Helper

public protocol EpisodeListRepository {
    func get(serie: Serie) async throws -> [Episode]
}

struct EpisodeListRepositoryImp: EpisodeListRepository  {
    
    private let urlSession: NetworkSession
    private let decoder: JSONDecoder
    
    public init(urlSession: NetworkSession,
                decoder: JSONDecoder) {
        self.urlSession = urlSession
        self.decoder = decoder
    }
    
    func get(serie: Serie) async throws -> [Episode] {
        
        let api = EpisodeListAPI(serie: serie)
        guard let urlRequest = api.build() else {
            throw BreakingBadError.malformedAPI
        }
        
        let (data, response) = try await urlSession.data(for: urlRequest)
        try response.throwOnFailureStatusCode()
        return try decoder.decode([Episode].self, from: data)
    }
}
