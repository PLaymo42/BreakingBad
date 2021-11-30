//
//  CharacterDetailUseCase.swift
//  
//
//  Created by Anthony Soulier on 29/11/2021.
//

import Foundation
import BreakingBadData

public protocol CharacterDetailUseCase {
    func get(id: Int) async throws -> CharacterDetailEntity?
}

public struct CharacterDetailUseCaseImp<CharacterDetailsRepo: CharacterDetailsRepository, QuoteForAuthorRepo: QuoteForAuthorRepository>: CharacterDetailUseCase
where CharacterDetailsRepo.OUT == CharacterEntity, QuoteForAuthorRepo.OUT == QuoteEntity {

    private let characterRepository: CharacterDetailsRepo
    private let quotesRepository: QuoteForAuthorRepo

    public init(characterRepository: CharacterDetailsRepo, quotesRepository: QuoteForAuthorRepo) {
        self.characterRepository = characterRepository
        self.quotesRepository = quotesRepository
    }

    public func get(id: Int) async throws -> CharacterDetailEntity? {
        let decoder = JSONDecoder()

        guard let character = try await characterRepository.get(id: id, decoder: decoder) else {
            return nil
        }

        let quotes = try await quotesRepository.get(forAuthor: character.name, decoder: decoder)

        return CharacterDetailEntity(
            infos: character,
            quotes: quotes
        )
    }

}
