//
//  NewEpisodesView.swift
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

struct NewEpisodesView: View {
    
    let data: Loadable<[Media]>
    let refreshHandler: () -> Void
    
    private let width: CGFloat = 160
    private let height: CGFloat = 228
    
    var body: some View {
        VStack {
            HStack {
                Text("New Episodes".localized)
                    .headline
                    .padding(.horizontal)
                Spacer()
            }.padding(.bottom, 8)
            newEpisodes
            Spacer()
        }
    }
    
    private var newEpisodes: some View {
        switch data {
        case .notRequested:
            return AnyView(Text(""))
        case .isLoading(last: let last, cancelBag: _):
            return AnyView(isLoadingView(last))
        case .loaded(let categories):
            return AnyView(loadedView(categories))
        case .failed(_):
            return AnyView(ErrorView() { self.refreshHandler() })
        }
    }
    
    private func isLoadingView(_ last: [Media]?) -> some View {
        ZStack {
            last.map { AnyView(self.loadedView($0)) } ?? AnyView(EmptyView())
            ActivityIndicatorView()
        }
    }
    
    private func loadedView(_ mediaList: [Media]) -> some View {
        MediaListView(mediaList: mediaList,
                      width: width,
                      height: height)
            .animation(.spring())
    }
}

#if DEBUG
struct NewEpisodesView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        NewEpisodesView(
            data: .loaded(NewEpisodesData.mockedData.data.media),
            refreshHandler: { })
    }
}
#endif

