//
//  Episode.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation

public struct Episode: Decodable {

    public var id: Int
    public var title: String
    public var season: String
    public var episode: String
    public var airDate: String
    public var characters: [String]

    enum CodingKeys: String, CodingKey {
        case id = "episode_id"
        case title
        case season
        case episode
        case airDate = "air_date"
        case characters
    }
}
