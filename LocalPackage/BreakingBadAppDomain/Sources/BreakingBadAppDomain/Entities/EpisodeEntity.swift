//
//  Episode.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation

public struct EpisodeEntity: Equatable {
    public init(id: Int,
                title: String,
                season: Int,
                episode: Int,
                airDate: String,
                characters: [String]
    ) {
        self.id = id
        self.title = title
        self.season = season
        self.episode = episode
        self.airDate = airDate
        self.characters = characters
    }

    public var id: Int
    public var title: String
    public var season: Int
    public var episode: Int
    public var airDate: String
    public var characters: [String]
}
