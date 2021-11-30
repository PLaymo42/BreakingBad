//
//  SeasonListView.swift
//  BreakingBad
//
//  Created by Anthony Soulier on 27/11/2021.
//

import SwiftUI
import BreakingBadAppDomain

class SeasonListViewModel: ObservableObject {
    private let useCase: EpisodeListUseCase

    @Published private(set) var seasons: [SeasonModel] = []

    init(useCase: EpisodeListUseCase) {
        self.useCase = useCase
    }

    func load() {
        Task {
            let episodes = try await useCase.get(serie: .breakingBad)
            let seasons = Dictionary(grouping: episodes, by: { $0.season })
                .sorted { $0.key < $1.key }
                .enumerated()
                .map {
                    SeasonModel(
                        id: $0.offset,
                        seasonTitle: "Season \($0.element.key)",
                        episodes: $0.element.value.map { episode in
                            EpisodeView.Model(
                                id: episode.id,
                                title: episode.title,
                                episodeNumberInfo: "S\(episode.season) | E\(episode.episode)",
                                seen: false,
                                airingDate: episode.airDate
                            )
                        }
                    )
                }
            DispatchQueue.main.async {
                self.seasons = seasons
            }
        }
    }
}

struct SeasonListView: View {

    @ObservedObject var viewModel: SeasonListViewModel

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 8) {
                ForEach(viewModel.seasons) {
                    SeasonView(season: $0)
                }
            }
        }.onAppear(perform: viewModel.load)
    }
}

struct SeasonListView_Previews: PreviewProvider {

    class EpisodeListUseCaseMock: EpisodeListUseCase {
        func get(serie: Serie) async throws -> [EpisodeEntity] {
            [
                .init(id: 0, title: "pilot", season: 1, episode: 1, airDate: "09-09-2020", characters: []),
                .init(id: 1, title: "pilot", season: 1, episode: 2, airDate: "09-09-2020", characters: []),
                .init(id: 2, title: "pilot", season: 1, episode: 3, airDate: "09-09-2020", characters: []),
                .init(id: 3, title: "pilot", season: 1, episode: 4, airDate: "09-09-2020", characters: []),
                .init(id: 4, title: "pilot", season: 1, episode: 5, airDate: "09-09-2020", characters: []),
                .init(id: 5, title: "pilot", season: 2, episode: 1, airDate: "09-09-2020", characters: []),
                .init(id: 6, title: "pilot", season: 2, episode: 2, airDate: "09-09-2020", characters: []),
                .init(id: 7, title: "pilot", season: 2, episode: 3, airDate: "09-09-2020", characters: []),
                .init(id: 8, title: "pilot", season: 2, episode: 4, airDate: "09-09-2020", characters: []),
                .init(id: 9, title: "pilot", season: 3, episode: 1, airDate: "09-09-2020", characters: []),
                .init(id: 10, title: "pilot", season: 3, episode: 2, airDate: "09-09-2020", characters: []),
                .init(id: 11, title: "pilot", season: 3, episode: 3, airDate: "09-09-2020", characters: []),
            ]
        }
    }


    static var previews: some View {
        SeasonListView(
            viewModel: SeasonListViewModel(
                useCase: EpisodeListUseCaseMock()
            )
        )
    }
}
