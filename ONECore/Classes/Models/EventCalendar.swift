//
//  EventCalendar.swift
//  ONECore
//
//  Created by NICKO PRASETIO on 06/11/19.
//

import Foundation
import EventKit

public class EventCalendar {
    open var title: String = DefaultValue.emptyString
    open var location: String = DefaultValue.emptyString
    open var startDate: Date = Date()
    open var endDate: Date = Date()
    open var desc: String = DefaultValue.emptyString
    public init() {}
}
