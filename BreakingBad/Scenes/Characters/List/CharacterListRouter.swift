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

    @MainActor
    func openDetail(id: Int) {

        // TODO: improve dependency injection
        let detailVC = CharacterDetailViewController(
            characterId: id,
            viewModel: CharacterDetailViewModel(
                useCase: CharacterDetailUseCaseImp(
                    characterRepository: Server.breakingBadService.characterDetailsRepository,
                    quotesRepository: Server.breakingBadService.quoteForAuthorRepository,
                    characterMapper: CharacterMapper(),
                    quoteMapper: QuoteMapper()
                ),
                imageFetcher: Dependencies.imageFetcher
            )
        )

        navigationController?.pushViewController(detailVC, animated: true)
    }
}
