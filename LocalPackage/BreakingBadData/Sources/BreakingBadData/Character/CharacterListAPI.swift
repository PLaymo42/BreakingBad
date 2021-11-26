//
//  CharacterListAPI.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation

struct CharacterListAPI: API {
    let urlRequest: URLRequest = {
        var url = URL(string: "https://www.breakingbadapi.com/api/")!
        url.appendPathComponent("characters")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        return urlRequest
    }()
}
