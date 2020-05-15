//
//  ChannelsView.swift
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

struct ChannelsView: View {
    private let mediaWidth: CGFloat = 160
    private let mediaHeight: CGFloat = 228
    
    let data: Loadable<[Channel]>
    let refreshHandler: () -> Void
    
    var body: some View {
        channels
    }
    
    private var channels: some View {
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
    
    private func isLoadingView(_ last: [Channel]?) -> some View {
        ZStack {
            last.map { AnyView(self.loadedView($0)) } ?? AnyView(EmptyView())
            ActivityIndicatorView()
        }
    }
    
    private func loadedView(_ channels: [Channel]) -> some View {
        VStack(alignment: .leading) {
            ForEach(0 ..< channels.count) { index in
                self.header(for: channels[index])
                    .padding(.bottom, 8)
                    .padding(.top, 16)
                
                if !channels[index].isSeries {
                    MediaListView(mediaList: channels[index].latestMedia ?? [],
                                  width: self.mediaWidth,
                                  height: self.mediaHeight)
                }
                
                if index < channels.count - 1 {
                    DividerView().padding(.top, 16)
                }
            }
        }
    }
    
    private func header(for channel: Channel) -> some View {
        HStack {
            IconView(url: channel.iconAsset?.combinedUrl,
                     edge: 50)
            VStack(alignment: .leading) {
                Text(channel.title)
                    .channel
                    .padding(.bottom, 2)
                if channel.isSeries {
                    Text("\(channel.series?.count ?? 0) series")
                        .channelCount
                } else {
                    Text("\(channel.mediaCount ?? 0) episodes")
                        .channelCount
                }
            }.padding(.horizontal, 8)
            Spacer()
        }.padding(.horizontal, 8)
    }
}

private extension Channel {
    var isSeries: Bool { !(self.series?.isEmpty ?? true) }
}

#if DEBUG
struct ChannelsView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelsView(
            data: .loaded(ChannelsData.mockedData.data.channels),
            refreshHandler: { })
    }
}
#endif
