//
//  DateHelper.swift
//  ONECore
//
//  Created by DENZA on 08/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

public class DateHelper {
    public static var dateFormatter: DateFormatter {
        get {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: Language.bahasa)
            return formatter
        }
    }
}
