//
//  ServiceSessionManager.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 07/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import Alamofire

open class ServiceSessionManager: SessionManager {
    private func getEncoding(_ method: HTTPMethod) -> ParameterEncoding {
        switch method {
        case .get: return URLEncoding(destination: .queryString)
        default: return JSONEncoding.default
        }
    }

    public func request(
        url: URLConvertible,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        timeoutInterval: TimeInterval
    ) -> DataRequest {
        let encoding = getEncoding(method)
        do {
            var originalRequest = try URLRequest(url: url, method: method, headers: headers)
            originalRequest.timeoutInterval = timeoutInterval
            let encodedURLRequest = try encoding.encode(originalRequest, with: parameters)
            return request(encodedURLRequest)
        } catch {
            return super.request(
                url,
                method: method,
                parameters: parameters,
                encoding: encoding,
                headers: headers
            )
        }
    }
}
