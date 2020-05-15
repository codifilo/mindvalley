//
//  SeriesListView.swift
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

struct SeriesListView: View {
    let seriesList: [SeriesItem]
    let width: CGFloat
    let height: CGFloat
    
    private let maxCount = 6
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0 ..< min(maxCount, seriesList.count)) { index in
                    self.itemView(for: self.seriesList[index])
                }
            }.padding(.horizontal, 8)
        }
    }
    
    private func itemView(for item: SeriesItem) -> some View {
        VStack(alignment: .leading) {
            CoverView(url: item.coverAsset.combinedUrl,
                      width: width,
                      height: height)
            
            Text(item.title)
                .title
                .fixedSize(horizontal: false, vertical: true)
                .padding(.vertical, 10)
            
            Spacer()
        }
        .frame(width: width)
        .padding(.horizontal, 5)
        .onTapGesture {
            Log.d("didTapSeriesItem=\(item.title)")
        }
    }
}

#if DEBUG
struct SeriesListView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesListView(seriesList: ChannelsData.mockedData.data.channels[0].series ?? [],
                       width: 160,
                       height: 228)
    }
}
#endif
