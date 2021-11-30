//
//  Quote.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation

public struct QuoteEntity: Equatable {
    public init(id: Int,
                quote: String,
                author: String
    ) {
        self.id = id
        self.quote = quote
        self.author = author
    }

    public var id: Int
    public var quote: String
    public var author: String
}
