//
//  Service+GetFoods.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 07/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ObjectMapper

extension Service {
    func getFoods(
        params: RequestGetFoods,
        success: @escaping (_ data: ResponseGetFoods) -> Void,
        failed: @escaping NetworkHandler.Failed,
        completion: @escaping NetworkHandler.Completion = {}
    ) {
        request(
            path: "/foods",
            method: .get,
            parameters: params.toJSON(),
            success: { (_ result: Any) in
                guard let data = Mapper<ResponseGetFoods>().map(JSONObject: result) else {
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
