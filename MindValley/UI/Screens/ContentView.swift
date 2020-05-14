//
//  ContentView.swift
//  MindValley
//
//  Created by Agustín Prats Hernandez on 13/05/2020.
//  Copyright © 2020 Agustín Prats Hernandez. All rights reserved.
//

import SwiftUI
import Introspect

struct ContentView: View {
    private let container: DIContainer
    @State private var categoriesData: Loadable<CategoriesData> = .notRequested
    
    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        CategoriesView(
            categoriesData: categoriesData,
            refreshHandler: { self.container.interactors.channels.refresh() })
        .onReceive(container.appState.updates(for: \.userData.categoriesData)) {
            self.categoriesData = $0
        }.onAppear() {
            self.categoriesData = self.container.appState[\.userData.categoriesData]
        }.introspectViewController { $0.view.backgroundColor = Color.background.uiColor }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(container: .preview)
    }
}
#endif
