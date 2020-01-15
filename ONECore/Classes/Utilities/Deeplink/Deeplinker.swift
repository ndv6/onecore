//
//  Deeplinker.swift
//  ONECore
//
//  Created by DENZA on 08/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

public struct DeeplinkHandler {
    public typealias Failed = () -> Void
    public typealias Success = () -> Void
    public typealias Completion = () -> Void
}

open class Deeplinker {
    open var path: String { get { return DefaultValue.emptyString } }
    open var isRequiredAuthToken: Bool { get { return true } }
    open var urlString: String = DefaultValue.emptyString
    open var queryItems: [URLQueryItem] = [URLQueryItem]()
    open func execute(
        success: @escaping DeeplinkHandler.Success,
        failed: @escaping DeeplinkHandler.Failed = {},
        completion: @escaping DeeplinkHandler.Completion = {}
    ) {}
    public init() {}
}
