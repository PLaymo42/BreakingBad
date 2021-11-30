//
//  EpisodeView.swift
//  BreakingBad
//
//  Created by Anthony Soulier on 27/11/2021.
//

import SwiftUI

struct EpisodeView: View {

    struct Model: Identifiable {
        var id: Int
        var title: String
        var episodeNumberInfo: String
        var seen: Bool
        var airingDate: String
    }

    @State var model: Model

    var body: some View {

        HStack(spacing: 16) {
            VStack(spacing: 4) {
                Text(model.episodeNumberInfo)
                    .font(.headline)
                Text(model.title)
                    .font(.subheadline)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                Text(model.airingDate)
                    .font(.caption)
            }

            Image(systemName: seenImageName)
                .font(.largeTitle)
                .onTapGesture {
                    model.seen.toggle()
                }

        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
        .shadow(radius: 8)
    }

    private var seenImageName: String {
        "checkmark.circle\(model.seen ? ".fill" : "")"
    }
}

struct EpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeView(model: .init(
            id: 0,
            title: "very long title",
            episodeNumberInfo: "S01 | E01",
            seen: true,
            airingDate: "20/01/2008"
        ))
    }
}
