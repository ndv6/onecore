//
//  UIActivityTypes.swift
//  ONECore
//
//  Created by Mac User on 15/10/19.
//

import UIKit

public struct UIActivityTypes {
    public static var excludedFromShareText: [UIActivity.ActivityType] = [
        UIActivity.ActivityType.postToWeibo,
        UIActivity.ActivityType.print,
        UIActivity.ActivityType.assignToContact,
        UIActivity.ActivityType.saveToCameraRoll,
        UIActivity.ActivityType.addToReadingList,
        UIActivity.ActivityType.postToFlickr,
        UIActivity.ActivityType.postToVimeo,
        UIActivity.ActivityType.postToTencentWeibo
    ]
}
