//
//  CharacterListRouter.swift
//  BreakingBad
//
//  Created by Anthony Soulier on 30/11/2021.
//

import Foundation
import UIKit
import BreakingBadAppDomain
import BreakingBadData

protocol CharacterListRouter {
    func openDetail(id: Int)
}

class CharacterListRouterImp: CharacterListRouter {

    weak var navigationController: UINavigationController?

    func openDetail(id: Int) {

        // TODO: improve dependency injection
        let detailVC = CharacterDetailViewController(
            characterId: id,
            viewModel: CharacterDetailViewModel(
                useCase: CharacterDetailUseCaseImp(
                    characterRepository: CharacterDetailsRepositoryImp(
                        api: CharacterDetailsAPI(),
                        urlSession: URLSession.shared,
                        mapper: CharacterMapper()
                    ),
                    quotesRepository: QuoteForAuthorRepositoryImp(
                        api: QuoteForAuthorAPI(),
                        urlSession: URLSession.shared,
                        mapper: QuoteMapper()
                    )
                ),
                imageFetcher: Dependencies.imageFetcher
            )
        )

        navigationController?.pushViewController(detailVC, animated: true)
    }
}
