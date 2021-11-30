//
//  QuoteView.swift
//  BreakingBad
//
//  Created by Anthony Soulier on 28/11/2021.
//

import SwiftUI

struct QuoteView: View {

    struct Model: Equatable {
        var text: String
        var author: String
    }

    var quote: Model

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(quote.text)
                .font(.largeTitle)
            Text(quote.author)
                .font(.footnote)
                .italic()
                .frame(alignment: .leading)
        }
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView(
            quote: .init(text: "Funyuns are awesome.", author: "Jesse Pinkman")
        )
    }
}
