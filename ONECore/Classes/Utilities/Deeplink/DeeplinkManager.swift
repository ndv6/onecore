//
//  DeeplinkManager.swift
//  ONECore
//
//  Created by DENZA on 25/02/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

public class DeeplinkManager {
    public static let instance = DeeplinkManager()
    private var linkers: [Deeplinker] = [Deeplinker]()
    private var incomingUrl: URL?

    public func setup(linkers: [Deeplinker]) {
        self.linkers = linkers
    }

    private func findLinker(path: String) -> Deeplinker {
        for linker in linkers where linker.path == path { return linker }
        return Deeplinker()
    }

    private func resetIncomingUrl() {
        incomingUrl = nil
    }

    public func registerIncomingUrl(_ url: URL) {
        self.incomingUrl = url
    }

    public func checkIncomingUrl() {
        guard let url = incomingUrl else { return }
        guard let component = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        let firstPath = url.pathComponents.prefix(2).joined()
        let linker = findLinker(path: firstPath)
        if let queryItems = component.queryItems {
            linker.queryItems = queryItems
        }
        linker.urlString = url.absoluteString
        linker.execute(success: { self.resetIncomingUrl() })
    }
}
