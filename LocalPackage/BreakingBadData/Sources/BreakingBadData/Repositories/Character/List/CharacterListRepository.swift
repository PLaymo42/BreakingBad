//
//  CharacterListRepository.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation
import Helper

public protocol CharacterListRepository {
    func get() async throws -> [Character]
}

struct CharacterListRepositoryImp: CharacterListRepository {
    
    private let urlSession: NetworkSession
    private let decoder: JSONDecoder
    
    public init(urlSession: NetworkSession,
                decoder: JSONDecoder) {
        self.urlSession = urlSession
        self.decoder = decoder
    }
    
    public func get() async throws -> [Character] {
        let api = CharacterListAPI()
        guard let urlRequest = api.build() else { throw BreakingBadError.malformedAPI }
        let (data, response) = try await urlSession.data(for: urlRequest)
        try response.throwOnFailureStatusCode()
        return try decoder.decode([Character].self, from: data)
    }
}
