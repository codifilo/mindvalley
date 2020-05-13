//
//  MockedData.swift
//  MindValley
//
//  Created by Agustín Prats Hernandez on 13/05/2020.
//  Copyright © 2020 Agustín Prats Hernandez. All rights reserved.
//

import Foundation

extension NewEpisodesData {
    static let mockedData = NewEpisodesData(
        data: [
            Media(type: .course,
                  title: "Title 1",
                  coverAsset: Asset(url: "https://assets.mindvalley.com/api/v1/assets/31998524-3925-41c1-b4b3-279d8c833558.jpg?transform=w_1080"),
                  channel: Channel(title: "Channel Title",
                                   coverAsset: nil,
                                   iconAsset: nil,
                                   mediaCount: nil,
                                   id: nil,
                                   series: nil,
                                   latestMedia: nil)),
            Media(type: .course,
                  title: "Title 2",
                  coverAsset: Asset(url: "https://assets.mindvalley.com/api/v1/assets/31998524-3925-41c1-b4b3-279d8c833558.jpg?transform=w_1080"),
                  channel: Channel(title: "Channel Title 2",
                                   coverAsset: nil,
                                   iconAsset: nil,
                                   mediaCount: nil,
                                   id: nil,
                                   series: nil,
                                   latestMedia: nil)),
            Media(type: .course,
                  title: "Title 3",
                  coverAsset: Asset(url: "https://assets.mindvalley.com/api/v1/assets/31998524-3925-41c1-b4b3-279d8c833558.jpg?transform=w_1080"),
                  channel: Channel(title: "Channel Title 3",
                                   coverAsset: nil,
                                   iconAsset: nil,
                                   mediaCount: nil,
                                   id: nil,
                                   series: nil,
                                   latestMedia: nil))])
}

extension ChannelsData {
    static let mockedData = ChannelsData(data: [
        Channel(title: "Channel Title 2",
                coverAsset: Asset(url: "https://assets.mindvalley.com/api/v1/assets/8fd5837a-539c-4367-b1af-8579a3e3d461.jpg?transform=w_1080"),
                iconAsset: Asset(url: "https://edgecastcdn.net/80EC13/public/overmind2/asset/11914f01-ba4a-4d68-9c33-efb34c43ed23/channel-icon-mentoring_thumbnail.png"),
                mediaCount: 1,
                id: 1,
                series: [SeriesItem(
                    title: "Series Title 1",
                    id: 1,
                    coverAsset: Asset(url: "https://assets.mindvalley.com/api/v1/assets/e019134c-fdb0-497c-a613-6b9f1c7166a4.jpg?transform=w_1080"))],
                latestMedia: nil)
    ])
}

extension CategoriesData {
    static let mockedData = CategoriesData(data: [
        Category(name: "Category 1"),
        Category(name: "Category 2"),
        Category(name: "Category 3")
    ])
}
