//
//  EpisodeListView.swift
//  BreakingBad
//
//  Created by Anthony Soulier on 27/11/2021.
//

import SwiftUI

struct SeasonModel: Identifiable {
    var id: Int
    var seasonTitle: String
    var episodes: [EpisodeView.Model]
}

struct SeasonView: View {

    @State var season: SeasonModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(season.seasonTitle)
                .font(.headline)
                .padding([.trailing, .leading])
            CarouselView(items: season.episodes, spacing: 16) { item in
                EpisodeView(model: item)
            }
        }
    }
}

struct SeasonView_Previews: PreviewProvider {
    static var previews: some View {
        SeasonView(
            season: .init(
                id: 1,
                seasonTitle: "Season 1",
                episodes: [
                    .init(
                        id: 0,
                        title: "Pilot",
                        episodeNumberInfo: "S01 | E01",
                        seen: true,
                        airingDate: "20/01/2008"
                    ),
                    .init(
                        id: 1,
                        title: "Cat's in the Bag...",
                        episodeNumberInfo: "S01 | E02",
                        seen: true,
                        airingDate: "27/01/2008"
                    ),
                    .init(
                        id: 2,
                        title: "...And the Bag's in the River",
                        episodeNumberInfo: "S01 | E03",
                        seen: true,
                        airingDate: "10/02/2008"
                    )
                ]
            )
        )
    }
}
