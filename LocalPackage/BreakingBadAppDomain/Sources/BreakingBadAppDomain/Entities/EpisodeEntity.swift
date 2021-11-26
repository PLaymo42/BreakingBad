//
//  Episode.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation

public struct EpisodeEntity: Decodable {
    public var id: Int
    public var title: String
    public var season: Int
    public var episode: Int
    public var airDate: String
    public var characters: [String]
}
