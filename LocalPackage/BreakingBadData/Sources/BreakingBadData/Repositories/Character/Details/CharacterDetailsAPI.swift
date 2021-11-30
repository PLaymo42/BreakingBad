//
//  CharacterDetailsAPI.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation

public struct CharacterDetailsAPI: API {

    public init() { }

    private var characterId: Int?

    mutating func setCharacterID(_ id: Int) {
        self.characterId = id
    }

    func build() -> URLRequest? {

        guard let characterId = characterId else {
            return nil
        }

        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "www.breakingbadapi.com"
        urlComponent.path = "/api/characters/\(characterId)"
        return urlComponent.url.flatMap { URLRequest(url: $0) }
    }
}
