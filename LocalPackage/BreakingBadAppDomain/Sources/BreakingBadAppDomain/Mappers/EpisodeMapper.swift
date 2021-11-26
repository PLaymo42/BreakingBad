//
//  EpisodeMapper.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation
import BreakingBadData

struct EpisodeMapper: Mapper {
    func map(from input: Episode) -> EpisodeEntity {
        .init(
            id: input.id,
            title: input.title,
            season: input.season,
            episode: input.episode,
            airDate: input.airDate,
            characters: input.characters
        )
    }
}
