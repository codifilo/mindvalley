//
//  MediaListView.swift
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

struct MediaListView: View {
    let mediaList: [Media]
    let width: CGFloat
    let height: CGFloat
    
    private let maxCount = 6
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0 ..< min(maxCount, mediaList.count)) { index in
                    self.mediaView(for: self.mediaList[index])
                }
            }.padding(.horizontal, 8)
        }
    }
    
    private func mediaView(for media: Media) -> some View {
        VStack(alignment: .leading) {
            CoverView(url: media.coverAsset.combinedUrl,
                      width: width,
                      height: height)
            
            Text(media.title)
                .title
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 10)
                
            if !(media.channel?.title.isEmpty ?? true) {
                Text(media.channel!.title.uppercased())
                    .subtitle
                    .padding(.vertical, 12)
            }
            
            Spacer()
        }
        .frame(width: width)
        .padding(.horizontal, 5)
        .onTapGesture {
            Log.d("didTapMedia=\(media.title)")
        }
    }
}

struct MediaListView_Previews: PreviewProvider {
    static var previews: some View {
        MediaListView(mediaList: NewEpisodesData.mockedData.data.media,
                      width: 160,
                      height: 228)
    }
}
