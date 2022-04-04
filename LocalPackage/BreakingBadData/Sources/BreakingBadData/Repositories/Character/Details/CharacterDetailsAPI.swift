//
//  CharacterDetailsAPI.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation

public struct CharacterDetailsAPI: API {

    private let characterId: Int

    public init(id: Int) {
        self.characterId = id
    }

    func build() -> URLRequest? {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "www.breakingbadapi.com"
        urlComponent.path = "/api/characters/\(characterId)"
        return urlComponent.url.flatMap { URLRequest(url: $0) }
    }
}
