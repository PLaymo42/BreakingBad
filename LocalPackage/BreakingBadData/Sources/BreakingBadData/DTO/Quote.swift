//
//  Quote.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation

public struct Quote: Decodable {
    public var id: Int
    public var quote: String
    public var author: String

    enum CodingKeys: String, CodingKey {
        case id = "quote_id"
        case quote
        case author
    }
}
