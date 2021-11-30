//
//  CharacterListViewModel.swift
//  BreakingBad
//
//  Created by Anthony Soulier on 30/11/2021.
//

import Foundation
import Combine
import BreakingBadAppDomain
import BreakingBadData

class CharacterListViewModel: ObservableObject {

    private let useCase: CharacterListUseCase
    private let imageLoader: ImageCacheLoader

    let router: CharacterListRouter

    init(useCase: CharacterListUseCase,
         imageLoader: ImageCacheLoader,
         router: CharacterListRouter) {
        self.useCase = useCase
        self.imageLoader = imageLoader
        self.router = router
    }

    @Published private(set) var items: [CharacterTableViewCell.Model] = []

    func load() {
        Task {
            let characters = (try? await useCase.get()) ?? []
            let items = characters.map {
                CharacterTableViewCell.Model(
                    id: $0.id,
                    name: $0.name,
                    nickname: $0.nickname,
                    imageURL: $0.headshotURL
                )
            }

            DispatchQueue.main.async {
                self.items = items
            }
        }
    }

    func fetchImage(for item: CharacterTableViewCell.Model) async {
        guard let url = item.imageURL, item.image == nil,
              let index = items.firstIndex(of: item) else { return }

        let image = try? await imageLoader.image(forURL: url)
        var item = item
        item.image = image
        self.items[index] = item
    }

}
