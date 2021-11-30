//
//  EpisodeMapper.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation
import BreakingBadData

public struct EpisodeMapper: Mapper {

    public init() { }

    public func map(from input: Episode) -> EpisodeEntity {
        .init(
            id: input.id,
            title: input.title,
            season: Int(input.season.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0,
            episode: Int(input.episode.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0,
            airDate: input.airDate,
            characters: input.characters
        )
    }
}
