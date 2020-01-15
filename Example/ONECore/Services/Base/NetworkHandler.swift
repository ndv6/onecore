//
//  NetworkHandler.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 07/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

public struct NetworkHandler {
    public typealias Failed = (_ error: ErrorResponse) -> Void
    public typealias Success = (_ result: Any) -> Void
    public typealias Completion = () -> Void
}
