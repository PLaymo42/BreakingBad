//
//  Quote.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation

public struct QuoteEntity: Decodable {
    public var id: Int
    public var quote: String
    public var author: String
}
