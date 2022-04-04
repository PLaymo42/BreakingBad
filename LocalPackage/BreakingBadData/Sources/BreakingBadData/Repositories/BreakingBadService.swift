//
//  BreakingBadService.swift
//  
//
//  Created by Anthony Soulier on 31/03/2022.
//

import Foundation

public class BreakingBadService {
    
    private let urlSession: URLSession
    
    private let decoder = JSONDecoder()
    
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    public private(set) lazy var characterDetailsRepository: CharacterDetailsRepository = CharacterDetailsRepositoryImp(
        urlSession: urlSession,
        decoder: decoder
    )
    
    public private(set) lazy var characterListRepository: CharacterListRepository = CharacterListRepositoryImp(
        urlSession: urlSession,
        decoder: decoder
    )
    
    public private(set) lazy var episodeListRepository: EpisodeListRepository = EpisodeListRepositoryImp(
        urlSession: urlSession,
        decoder: decoder
    )
    
    public private(set) lazy var randomQuoteRepository: RandomQuoteRepository = RandomQuoteRepositoryImp(
        urlSession: urlSession,
        decoder: decoder
    )
    
    public private(set) lazy var quoteForAuthorRepository: QuoteForAuthorRepository = QuoteForAuthorRepositoryImp(
        urlSession: urlSession,
        decoder: decoder
    )
    
}
