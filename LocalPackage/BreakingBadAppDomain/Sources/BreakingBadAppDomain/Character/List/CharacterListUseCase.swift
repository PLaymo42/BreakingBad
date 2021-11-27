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

public struct CharacterListUseCaseImp<CharacterListRepo: CharacterListRepository>: CharacterListUseCase where CharacterListRepo.OUT == CharacterEntity {

    private let characterListRepository: CharacterListRepo

    public init(characterListRepository: CharacterListRepo) {
        self.characterListRepository = characterListRepository
    }

    public func get() async throws -> [CharacterEntity] {
        try await characterListRepository.get(decoder: JSONDecoder())
    }

}
