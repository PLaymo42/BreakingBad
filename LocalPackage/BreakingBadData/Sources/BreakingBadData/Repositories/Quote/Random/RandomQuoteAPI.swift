//
//  RandomQuoteAPI.swift
//  
//
//  Created by Anthony Soulier on 28/11/2021.
//

import Foundation

struct RandomQuoteAPI: API {

    func build() -> URLRequest? {
        URLRequest(url: URL(string: "https://www.breakingbadapi.com/api/quote/random")!)
    }
}
