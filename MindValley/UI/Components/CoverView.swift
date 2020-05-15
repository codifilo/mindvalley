//
//  CoverView.swift
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
import KingfisherSwiftUI
import Kingfisher

struct CoverView: SwiftUI.View {
    let url: URL?
    var width: CGFloat
    let height: CGFloat
    
    var body: some SwiftUI.View {
        let processor =
            DownsamplingImageProcessor(size: CGSize(width: height,
                                                    height: height))
                |> CroppingImageProcessor(size: CGSize(width: width,
                                                       height: height))
        
        let placeHolder = AnyView(Color.lightBackground)
        
        let main = url.map({ AnyView(KFImage($0,
                       options: [.processor(processor),
                                 .scaleFactor(UIScreen.main.scale),
                                 .transition(.fade(1)),
            .cacheOriginalImage])
            .placeholder({ placeHolder })) }) ?? placeHolder
        
        
        return AnyView(main
            .frame(width: width, height: height)
            .cornerRadius(10))
    }
}

struct CoverView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        CoverView(url: URL(string: "https://assets.mindvalley.com/api/v1/assets/cb8c79d9-af35-4727-9c4c-6e9eee5af1c3.jpg?transform=w_1080")!, width: 160, height: 228)
    }
}
