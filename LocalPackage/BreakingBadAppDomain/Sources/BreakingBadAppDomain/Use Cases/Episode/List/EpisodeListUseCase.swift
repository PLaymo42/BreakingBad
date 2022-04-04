//
//  CharacterListUseCase.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation
import BreakingBadData

public protocol EpisodeListUseCase {
    func get(serie: Serie) async throws -> [EpisodeEntity]
}

public enum Serie {
    case breakingBad
    case betterCallSaul
}

extension BreakingBadData.Serie {
    init(from serie: Serie) {
        switch serie {
        case .breakingBad:
            self = .breakingBad
        case .betterCallSaul:
            self = .betterCallSaul
        }
    }
}

public struct EpisodeListUseCaseImp: EpisodeListUseCase {

    private let episodeListRepository: EpisodeListRepository
    private let mapper: EpisodeMapper
    
    public init(episodeListRepository: EpisodeListRepository,
                mapper: EpisodeMapper) {
        self.episodeListRepository = episodeListRepository
        self.mapper = mapper
    }

    public func get(serie: Serie) async throws -> [EpisodeEntity] {
        try await episodeListRepository.get(serie: .init(from: serie))
            .map { mapper.map(from: $0) }
    }

}
