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

public struct CharacterDetailUseCaseImp: CharacterDetailUseCase {

    private let characterRepository: CharacterDetailsRepository
    private let quotesRepository: QuoteForAuthorRepository
    private let characterMapper: CharacterMapper
    private let quoteMapper: QuoteMapper

    public init(characterRepository: CharacterDetailsRepository,
                quotesRepository: QuoteForAuthorRepository,
                characterMapper: CharacterMapper,
                quoteMapper: QuoteMapper) {
        self.characterRepository = characterRepository
        self.quotesRepository = quotesRepository
        self.characterMapper = characterMapper
        self.quoteMapper = quoteMapper
    }

    public func get(id: Int) async throws -> CharacterDetailEntity? {
        
        guard let character = try await characterRepository.get(id: id) else {
            return nil
        }

        let quotes = try await quotesRepository.get(forAuthor: character.name)

        return CharacterDetailEntity(
            infos: characterMapper.map(from: character),
            quotes: quotes.map { quoteMapper.map(from: $0) }
        )
    }

}
