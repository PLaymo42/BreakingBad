//
//  CharacterListUseCase.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation
import BreakingBadData

public protocol CharacterListUseCase {
    func get() async throws -> [CharacterEntity]
}

public struct CharacterListUseCaseImp: CharacterListUseCase {

    private let characterListRepository: CharacterListRepository
    private let mapper: CharacterMapper
    
    public init(characterListRepository: CharacterListRepository,
                mapper: CharacterMapper) {
        self.characterListRepository = characterListRepository
        self.mapper = mapper
    }

    public func get() async throws -> [CharacterEntity] {
        try await characterListRepository.get()
            .map { mapper.map(from: $0)  }
    }

}
