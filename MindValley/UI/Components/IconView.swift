//
//  IconView.swift
//  MindValley
//
//  Created by Agustín Prats Hernandez on 15/05/2020.
//  Copyright © 2020 Agustín Prats Hernandez. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI
import Kingfisher

struct IconView: SwiftUI.View {
    let url: URL?
    var edge: CGFloat
    
    var body: some SwiftUI.View {
        let processor =
            DownsamplingImageProcessor(size: CGSize(width: edge,
                                                    height: edge))
        
        let placeHolder = Color.lightBackground
        
        let main = url.map { AnyView(KFImage($0,
                   options: [.processor(processor),
                             .scaleFactor(UIScreen.main.scale),
                             .transition(.fade(1)),
                             .cacheOriginalImage])
            .placeholder({ placeHolder } ))}
            ?? AnyView(placeHolder)
        
        return main
            .frame(width: edge, height: edge)
            .cornerRadius(edge / 2.0)
    }
}

#if DEBUG
struct IconView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        IconView(url: URL(string: "https://edgecastcdn.net/80EC13/public/overmind2/asset/11914f01-ba4a-4d68-9c33-efb34c43ed23/channel-icon-mentoring_thumbnail.png")!, edge: 50)
    }
}
#endif
