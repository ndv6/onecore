//
//  Service+GetDrinks.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 13/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ObjectMapper

extension Service {
    func getDrinks(
        params: RequestGetDrinks,
        success: @escaping (_ data: ResponseGetDrinks) -> Void,
        failed: @escaping NetworkHandler.Failed,
        completion: @escaping NetworkHandler.Completion = {}
        ) {
        request(
            path: "/drinks",
            method: .get,
            parameters: params.toJSON(),
            success: { (_ result: Any) in
                guard let data = Mapper<ResponseGetDrinks>().map(JSONObject: result) else {
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
