//
//  RandomQuoteUseCase.swift
//  
//
//  Created by Anthony Soulier on 28/11/2021.
//

import Foundation
import BreakingBadData

public protocol RandomQuoteUseCase {
    func get() async throws -> QuoteEntity?
}

public struct RandomQuoteUseCaseImp: RandomQuoteUseCase {

    private let quoteRepository: RandomQuoteRepository
    private let mapper: QuoteMapper

    public init(quoteRepository: RandomQuoteRepository,
                mapper: QuoteMapper) {
        self.quoteRepository = quoteRepository
        self.mapper = mapper
    }

    public func get() async throws -> QuoteEntity? {
        try await quoteRepository.get()
            .map { mapper.map(from: $0) }
    }
}
