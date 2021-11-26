//
//  CharacterListRepository.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation

public protocol CharacterListRepository {
    associatedtype OUT
    func get(decoder: JSONDecoder) async throws -> [OUT]
}

struct CharacterListRepositoryImp<M: Mapper>: CharacterListRepository where M.IN == Character {

    private let api: CharacterListAPI
    private let mapper: M
    private let urlSession: URLSession

    init(api: CharacterListAPI,
        urlSession: URLSession,
         mapper: M) {
        self.mapper = mapper
        self.urlSession = urlSession
        self.api = api
    }

    func get(decoder: JSONDecoder) async throws -> [M.OUT] {
        let (data, response) = try await urlSession.data(for: api.urlRequest)
        try response.throwOnFailureStatusCode()
        let decoded = try decoder.decode([M.IN].self, from: data)
        return decoded.map { mapper.map(from: $0) }
    }
}
