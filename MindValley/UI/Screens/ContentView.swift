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
    @State private var newEpisodesData: Loadable<NewEpisodesData> = .notRequested
    @State private var channelsData: Loadable<ChannelsData> = .notRequested
    @State private var categoriesData: Loadable<CategoriesData> = .notRequested
    
    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        ScrollView {
            header
            NewEpisodesView(
                data: newEpisodesData,
                refreshHandler: {
                    self.container.interactors.channels.loadNewEpisodes()
            })
            DividerView()
            ChannelsView(
                data: channelsData,
                refreshHandler: {
                    self.container.interactors.channels.loadChannels()
            })
            DividerView()
            CategoriesView(
                data: categoriesData,
                refreshHandler: {
                    self.container.interactors.channels.loadCategories()
            })
        }
        .onReceive(container.appState.updates(for: \.userData.newEpisodesData)) {
            self.newEpisodesData = $0
        }
        .onReceive(container.appState.updates(for: \.userData.channelsData)) {
            self.channelsData = $0
        }
        .onReceive(container.appState.updates(for: \.userData.categoriesData)) {
            self.categoriesData = $0
        }.onAppear() {
            self.newEpisodesData = self.container.appState[\.userData.newEpisodesData]
            self.channelsData = self.container.appState[\.userData.channelsData]
            self.categoriesData = self.container.appState[\.userData.categoriesData]
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
