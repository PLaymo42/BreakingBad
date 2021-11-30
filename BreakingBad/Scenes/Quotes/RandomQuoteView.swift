//
//  RandomQuoteView.swift
//  BreakingBad
//
//  Created by Anthony Soulier on 28/11/2021.
//

import SwiftUI
import BreakingBadAppDomain

class RandomQuoteViewModel: ObservableObject {

    private let useCase: RandomQuoteUseCase

    init(useCase: RandomQuoteUseCase) {
        self.useCase = useCase
    }

    @Published private(set) var quote: QuoteView.Model?

    func load() {
        Task {
            let fetched = try? await useCase.get()
            let quote = fetched.map {
                QuoteView.Model(text: $0.quote, author: $0.author)
            }
            DispatchQueue.main.async {
                self.quote = quote
            }
        }
    }

}

struct RandomQuoteView: View {

    @ObservedObject var viewModel: RandomQuoteViewModel

    @State private var angle: Double = 0
    @State private var scale: Double = 1

    private var text: String? {
        viewModel.quote?.text
    }

    var body: some View {
        VStack {
            Spacer()
            if let quote = viewModel.quote {
                QuoteView(quote: quote)
                    .padding()
                    .rotationEffect(.degrees(angle))
                    .scaleEffect(scale)
                    .onChange(of: self.viewModel.quote?.text) {newValue in
                        withAnimation(.linear(duration: 0.2)) {
                            angle += 180
                            scale = 0.5
                        }
                        withAnimation(.linear(duration: 0.2).delay(0.2)) {
                            angle += 180
                            scale = 1
                        }
                    }
            }
            Spacer()
            Button(action: viewModel.load) {
                HStack {
                    Image(systemName: "arrow.clockwise")
                    Text("New quote")
                }
                .padding(8)
                .background(
                    Color(uiColor: .secondarySystemBackground)
                )
                .cornerRadius(4)
                .shadow(radius: 4)
            }
            .padding()
        }.onAppear(perform: viewModel.load)
    }
}

struct RandomQuoteView_Previews: PreviewProvider {

    struct RandomQuoteUseCaseMock: RandomQuoteUseCase {
        func get() async throws -> QuoteEntity? {
            .init(
                id: 0,
                quote: "Funyuns are awesome.",
                author: "Jessy Pinkman"
            )
        }
    }

    static var previews: some View {
        RandomQuoteView(
            viewModel: .init(
                useCase: RandomQuoteUseCaseMock()
            )
        )
    }
}
