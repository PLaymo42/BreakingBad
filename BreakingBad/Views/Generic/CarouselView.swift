//
//  CarouselView.swift
//  BreakingBad
//
//  Created by Anthony Soulier on 27/11/2021.
//

import SwiftUI

struct CarouselView<Element: Identifiable, Content: View>: View {

    @State var items: [Element]
    private(set) var spacing: CGFloat? = nil
    private(set) var showsIndicators: Bool = false
    @ViewBuilder var cellProvider: (Element) -> Content

    var body: some View {
        ScrollView(.horizontal, showsIndicators: showsIndicators) {
            LazyHStack(spacing: spacing) {
                ForEach(items) {
                    cellProvider($0)
                }
            }
            .padding()
        }
    }
}


struct CarouselView_Previews: PreviewProvider {

    struct PreviewItem: Identifiable {
        var text: String
        var id = UUID()
    }

    static var previews: some View {
        CarouselView(
            items: [
                PreviewItem(text: "text 1"),
                PreviewItem(text: "text 2"),
                PreviewItem(text: "text 3"),
                PreviewItem(text: "text 4"),
                PreviewItem(text: "text 5"),
                PreviewItem(text: "text 6"),
                PreviewItem(text: "text 7")]) {
                    Text($0.text)
            }
    }
}
