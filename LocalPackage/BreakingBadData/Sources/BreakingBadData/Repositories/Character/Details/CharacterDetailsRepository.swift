//
//  CharacterListRepository.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation
import Helper

public protocol CharacterDetailsRepository {
    func get(id: Int) async throws -> Character?
}

struct CharacterDetailsRepositoryImp: CharacterDetailsRepository {
    
    private let urlSession: NetworkSession
    private let decoder: JSONDecoder
    
    init(urlSession: NetworkSession,
         decoder: JSONDecoder) {
        self.urlSession = urlSession
        self.decoder = decoder
    }
    
    func get(id: Int) async throws -> Character? {
        let api = CharacterDetailsAPI(id: id)
        guard let urlRequest = api.build() else { throw BreakingBadError.malformedAPI }
        
        let (data, response) = try await urlSession.data(for: urlRequest)
        try response.throwOnFailureStatusCode()
        let decoded = try decoder.decode([Character].self, from: data)
        return decoded.first
    }
}
