
//  EpisodeListAPI.swift
//  
//
//  Created by Anthony Soulier on 27/11/2021.
//

import Foundation

public enum Serie: String {
    case breakingBad = "Breaking Bad"
    case betterCallSaul = "Better Call Saul"
}

struct EpisodeListAPI: API {

    var serie: Serie

    private var pathParameters: [String: String] {
        ["serie": serie.rawValue]
    }

    func build() -> URLRequest? {

        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "www.breakingbadapi.com"
        urlComponent.path = "/api/episodes"

        urlComponent.queryItems = pathParameters
            .mapValues { $0.replacingOccurrences(of: " ", with: "+") }
            .map { URLQueryItem(name: $0.key, value: $0.value) }

        return urlComponent.url.flatMap { URLRequest(url: $0) }
    }
}
