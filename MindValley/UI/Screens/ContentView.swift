//
//  ContentView.swift
//  MindValley
//
//  Copyright © 2020 Agustín Prats.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import SwiftUI
import Introspect

struct ContentView: View {
    private let container: DIContainer
    @State private var newEpisodes: Loadable<[Media]> = .notRequested
    @State private var channels: Loadable<[Channel]> = .notRequested
    @State private var categories: Loadable<[Category]> = .notRequested
    
    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            header.padding(.vertical, 30)
            NewEpisodesView(
                data: newEpisodes,
                refreshHandler: {
                    self.container.interactors.channels.loadNewEpisodes()
            })
            DividerView()
            ChannelsView(
                data: channels,
                refreshHandler: {
                    self.container.interactors.channels.loadChannels()
            })
            DividerView()
            CategoriesView(
                data: categories,
                refreshHandler: {
                    self.container.interactors.channels.loadCategories()
            })
        }
        .onReceive(container.appState.updates(for: \.userData.newEpisodes)) {
            self.newEpisodes = $0
        }
        .onReceive(container.appState.updates(for: \.userData.channels)) {
            self.channels = $0
        }
        .onReceive(container.appState.updates(for: \.userData.categories)) {
            self.categories = $0
        }.onAppear() {
            self.newEpisodes = self.container.appState[\.userData.newEpisodes]
            self.channels = self.container.appState[\.userData.channels]
            self.categories = self.container.appState[\.userData.categories]
        }.introspectViewController { $0.view.backgroundColor = Color.background.uiColor }
    }
    
    private var header: some View {
        HStack {
            Text("Channels".localized)
                .header
                .padding()
            Spacer()
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(container: .preview)
    }
}
#endif
