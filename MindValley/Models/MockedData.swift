//
//  MockedData.swift
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

import Foundation

extension NewEpisodesData {
    static let mockedData = NewEpisodesData(data: .init(media: [
            Media(type: .course,
                  title: "Title 1",
                  coverAsset: Asset(url: "https://assets.mindvalley.com/api/v1/assets/31998524-3925-41c1-b4b3-279d8c833558.jpg?transform=w_1080",
                                    thumbnailUrl: nil),
                  channel: Channel(title: "Channel Title",
                                   coverAsset: nil,
                                   iconAsset: nil,
                                   mediaCount: nil,
                                   id: nil,
                                   series: nil,
                                   latestMedia: nil)),
            Media(type: .course,
                  title: "Title 2",
                  coverAsset: Asset(url: "https://assets.mindvalley.com/api/v1/assets/31998524-3925-41c1-b4b3-279d8c833558.jpg?transform=w_1080",
                                    thumbnailUrl: nil),
                  channel: Channel(title: "Channel Title 2",
                                   coverAsset: nil,
                                   iconAsset: nil,
                                   mediaCount: nil,
                                   id: nil,
                                   series: nil,
                                   latestMedia: nil)),
            Media(type: .course,
                  title: "Title 3",
                  coverAsset: Asset(url: "https://assets.mindvalley.com/api/v1/assets/31998524-3925-41c1-b4b3-279d8c833558.jpg?transform=w_1080",
                                    thumbnailUrl: nil),
                  channel: Channel(title: "Channel Title 3",
                                   coverAsset: nil,
                                   iconAsset: nil,
                                   mediaCount: nil,
                                   id: nil,
                                   series: nil,
                                   latestMedia: nil))]))
}

extension ChannelsData {
    static let mockedData = ChannelsData(data: .init(channels: [
        Channel(title: "Channel Title 2",
                coverAsset: Asset(url: "https://assets.mindvalley.com/api/v1/assets/8fd5837a-539c-4367-b1af-8579a3e3d461.jpg?transform=w_1080",
                                  thumbnailUrl: nil),
                iconAsset: Asset(url: "https://edgecastcdn.net/80EC13/public/overmind2/asset/11914f01-ba4a-4d68-9c33-efb34c43ed23/channel-icon-mentoring_thumbnail.png",
                                 thumbnailUrl: nil),
                mediaCount: 1,
                id: "1",
                series: [SeriesItem(
                    title: "Series Title 1",
                    id: "1",
                    coverAsset: Asset(url: "https://assets.mindvalley.com/api/v1/assets/e019134c-fdb0-497c-a613-6b9f1c7166a4.jpg?transform=w_1080",
                                      thumbnailUrl: nil))],
                latestMedia: nil)
    ]))
}

extension CategoriesData {
    static let mockedData = CategoriesData(data: .init(categories: [
        Category(name: "Category 1"),
        Category(name: "Category 2"),
        Category(name: "Category 3")
    ]))
}
