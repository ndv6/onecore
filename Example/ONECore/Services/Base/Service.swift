//
//  Service.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 07/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ONECore
import Alamofire
import ObjectMapper

class Service {
    private var baseUrl: String = DefaultValue.emptyString
    private let sessionManager = ServiceSessionManager()

    init(baseUrl: String = DefaultValue.emptyString) {
        self.baseUrl = baseUrl
    }

    private func isSuccess(response: DataResponse<Any>) -> Bool {
        guard let statusCode = response.response?.statusCode else { return false }
        return statusCode >= 200 && statusCode < 300
    }

    private func responseHandler(
        response: DataResponse<Any>,
        success: @escaping NetworkHandler.Success,
        failed: @escaping NetworkHandler.Failed,
        completion: @escaping NetworkHandler.Completion = {}
    ) {
        if let value = response.result.value {
            if isSuccess(response: response) {
                success(value)
                completion()
                return
            } else if let data = Mapper<ErrorResponse>().map(JSONObject: value) {
                failed(data)
                completion()
                return
            }
        }
        if response.result.error != nil, let response = response.response {
            failed(ErrorResponse(code: String(response.statusCode)))
            completion()
            return
        }
        failed(ErrorResponse(code: String(NSURLErrorUnknown)))
        completion()
        return
    }

    public func request(
        path: String,
        method: HTTPMethod = .get,
        parameters: [String: Any]? = [String: Any](),
        headers: [String: String]? = [String: String](),
        success: @escaping NetworkHandler.Success,
        failed: @escaping NetworkHandler.Failed,
        completion: @escaping NetworkHandler.Completion = {}
    ) {
        sessionManager.request(
            url: baseUrl + path,
            method: method,
            timeoutInterval: 10
        ).responseJSON { response in
            self.responseHandler(
                response: response,
                success: success,
                failed: failed,
                completion: completion
            )
        }
    }
}
