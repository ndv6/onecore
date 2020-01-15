//
//  Float+Extension.swift
//  Alamofire
//
//  Created by Sofyan Fradenza Adi on 10/05/19.
//

import Foundation

public extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }

    func rounded(toPlaces places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
