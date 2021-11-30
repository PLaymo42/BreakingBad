
//  EpisodeListAPI.swift
//  
//
//  Created by Anthony Soulier on 27/11/2021.
//

import Foundation

public struct EpisodeListAPI: API {

    public enum Serie: String {
        case breakingBad = "Breaking Bad"
        case betterCallSaul = "Better Call Saul"
    }

    public init() { }

    private var pathParameters = [String: String]()

    mutating func setSerie(_ serie: Serie) {
        pathParameters["series"] = serie.rawValue
    }

    func build() -> URLRequest? {

        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "www.breakingbadapi.com"
        urlComponent.path = "/api/episodes"

        urlComponent.queryItems = pathParameters.map {
            URLQueryItem(name: $0.key, value: $0.value.replacingOccurrences(of: " ", with: "+"))
        }

        return urlComponent.url.flatMap { URLRequest(url: $0) }
    }
}
