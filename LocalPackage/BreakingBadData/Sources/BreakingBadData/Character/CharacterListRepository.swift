//
//  CharacterListRepository.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation
import Helper

public protocol CharacterListRepository {
    associatedtype OUT
    func get(decoder: JSONDecoder) async throws -> [OUT]
}

public struct CharacterListRepositoryImp<M: Mapper>: CharacterListRepository where M.IN == Character {
    
    private let api: CharacterListAPI
    private let mapper: M
    private let urlSession: URLSession

    public init(api: CharacterListAPI,
         urlSession: URLSession,
         mapper: M) {
        self.mapper = mapper
        self.urlSession = urlSession
        self.api = api
    }

    public func get(decoder: JSONDecoder) async throws -> [M.OUT] {
        let (data, response) = try await urlSession.data(for: api.urlRequest)
        try response.throwOnFailureStatusCode()
        let decoded = try decoder.decode([M.IN].self, from: data)
        return decoded.map { mapper.map(from: $0) }
    }
}
