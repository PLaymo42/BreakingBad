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

public struct RandomQuoteUseCaseImp<RandomQuoteRepo: RandomQuoteRepository>: RandomQuoteUseCase
where RandomQuoteRepo.OUT == QuoteEntity {

    private let quoteRepository: RandomQuoteRepo

    public init(quoteRepository: RandomQuoteRepo) {
        self.quoteRepository = quoteRepository
    }

    public func get() async throws -> QuoteEntity? {
        try await quoteRepository.get(decoder: JSONDecoder())
    }
}
