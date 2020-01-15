//
//  Service+GetPlaces.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 13/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ObjectMapper

extension Service {
    func getPlaces(
        params: RequestGetPlaces,
        success: @escaping (_ data: ResponseGetPlaces) -> Void,
        failed: @escaping NetworkHandler.Failed,
        completion: @escaping NetworkHandler.Completion = {}
    ) {
        request(
            path: "/wine-places",
            method: .get,
            parameters: params.toJSON(),
            success: { (_ result: Any) in
                guard let data = Mapper<ResponseGetPlaces>().map(JSONObject: result) else {
                    failed(ErrorResponse(code: String(NSURLErrorUnknown)))
                    return
                }
                success(data)
                return
            },
            failed: failed,
            completion: completion
        )
    }
}
