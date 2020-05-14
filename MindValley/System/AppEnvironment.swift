//
//  PortraitView.swift
//  TuneIt
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

import UIKit
import Combine

struct AppEnvironment {
    let container: DIContainer
    let systemEventsHandler: SystemEventsHandler
}

extension AppEnvironment {
    
    static func bootstrap() -> AppEnvironment {
        let session = configuredURLSession()
        let repositories = configuredWebRepositories(session: session)
        let appState = Store<AppState>(AppState())
        let interactors = configuredInteractors(appState: appState,
                                                repositories: repositories)
        let diContainer = DIContainer(
            appState: appState,
            interactors: interactors)
        let systemEventsHandler = RealSystemEventsHandler(
            container: diContainer)
        
        return AppEnvironment(container: diContainer,
                              systemEventsHandler: systemEventsHandler)
    }
    
    private static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return URLSession(configuration: configuration)
    }
    
    private static func configuredInteractors(
        appState: Store<AppState>,
        repositories: DIContainer.WebRepositories) -> DIContainer.Interactors {
        
        return .init(channelsInteractor: RealChannelsInteractor(
                appState: appState,
                webRepository: repositories.channels))
    }
    
    private static func configuredWebRepositories(
        session: URLSession) -> DIContainer.WebRepositories {
        
        return .init(
            channels: RealChannelsWebRepository(
                session: session,
                baseURL: "https://pastebin.com"))
    }
}

extension DIContainer {
    struct WebRepositories {
        let channels: ChannelsWebRepository
    }
}
