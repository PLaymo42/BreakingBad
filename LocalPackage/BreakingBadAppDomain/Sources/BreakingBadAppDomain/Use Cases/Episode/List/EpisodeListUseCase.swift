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

extension EpisodeListAPI.Serie {
    init(from serie: Serie) {
        switch serie {
        case .breakingBad:
            self = .breakingBad
        case .betterCallSaul:
            self = .betterCallSaul
        }
    }
}

public struct EpisodeListUseCaseImp<EpisodeListRepo: EpisodeListRepository>: EpisodeListUseCase
where EpisodeListRepo.OUT == EpisodeEntity {

    private let episodeListRepository: EpisodeListRepo

    public init(episodeListRepository: EpisodeListRepo) {
        self.episodeListRepository = episodeListRepository
    }

    public func get(serie: Serie) async throws -> [EpisodeEntity] {
        try await episodeListRepository.get(serie: .init(from: serie), decoder: JSONDecoder())
    }

}
