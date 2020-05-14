//
//  PortraitView.swift
//  TuneIt
//
//  Created by Agustín Prats Hernandez on 22/04/2020.
//

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
        configuration.requestCachePolicy = .returnCacheDataElseLoad
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
