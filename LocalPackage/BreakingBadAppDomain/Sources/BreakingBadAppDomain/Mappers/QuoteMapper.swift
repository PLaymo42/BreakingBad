//
//  QuoteMapper.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation
import BreakingBadData

public struct QuoteMapper: Mapper {

    public init() { }

    public func map(from input: Quote) -> QuoteEntity {
        .init(
            id: input.id,
            quote: input.quote,
            author: input.author
        )
    }
}
