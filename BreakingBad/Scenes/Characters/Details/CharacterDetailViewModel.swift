//
//  CharacterDetailViewModel.swift
//  BreakingBad
//
//  Created by Anthony Soulier on 30/11/2021.
//

import Foundation
import UIKit
import BreakingBadAppDomain
import Combine

@MainActor
class CharacterDetailViewModel: ObservableObject {

    private let useCase: CharacterDetailUseCase
    private let imageFetcher: ImageCacheLoader

    init(useCase: CharacterDetailUseCase, imageFetcher: ImageCacheLoader) {
        self.useCase = useCase
        self.imageFetcher = imageFetcher
    }

    @Published var model: CharacterDetailViewController.Model?

    func load(id: Int) async {
        Task {
            guard let character = try? await useCase.get(id: id) else {
                return
            }

            let model = CharacterDetailViewController.Model(
                title: character.infos.name,
                header: .init(
                    nickname: "a.k.a \(character.infos.nickname)",
                    birthday: character.infos.birthday,
                    playedBy: "Played by: \(character.infos.portrayed)",
                    headshot: nil,
                    statusImage: image(forStatus: character.infos.status),
                    statusImageColor: color(forStatus: character.infos.status)
                ),
                quotes: character.quotes.map { $0.quote }
            )
            
            self.model = model

            if let url = character.infos.headshotURL,
               let image = try? await imageFetcher.image(forURL: url) {
                
                var model = self.model
                model?.header.headshot = image
                self.model = model
            }
        }
    }

    private func image(forStatus status: CharacterEntity.Status) -> UIImage? {
        switch status {
        case .alive:
            return UIImage(systemName: "heart.fill")
        case .presumedDead, .dead:
            return UIImage(systemName: "heart.slash")
        case .unknown:
            return UIImage(systemName: "questionmark")
        }
    }

    private func color(forStatus status: CharacterEntity.Status) -> UIColor {
        switch status {
        case .alive:
            return .systemRed
        case .presumedDead, .dead, .unknown:
            return .systemGray
        }
    }
}
