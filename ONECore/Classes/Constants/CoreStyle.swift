//
//  CoreStyle.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 11/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

public struct CoreStyle {
    public struct Font {
        public static var navigationTitle: UIFont = UIFont.systemFont(ofSize: 10)
    }
    public struct Image {
        public static var navigationBackButton: UIImage = UIImage()
        public static var navigationCloseButton: UIImage = UIImage()
        public static var dropDownArrow: UIImage = UIImage()
        public static var calendarPicker: UIImage = UIImage()
        public static var currencyIDRActive: UIImage = UIImage()
        public static var currencyIDRInactive: UIImage = UIImage()
        public static var eyeButtonOpen: UIImage = UIImage()
        public static var eyeButtonClose: UIImage = UIImage()
        public static var checkedBox: UIImage = UIImage()
        public static var uncheckedBox: UIImage = UIImage()
    }
    public struct Color {
        public static var navigationBarSeparator: UIColor = .clear
        public static var navigationBackground: UIColor = .groupTableViewBackground
        public static var navigationText: UIColor = .black
        public static var primaryBackground: UIColor = .groupTableViewBackground
        public static var imageBackground: UIColor = .gray
        public static var inputAccessoryActive: UIColor = .clear
        public static var inputAccessoryInactive: UIColor = .clear
    }
    public struct EmptySection {
        public static var xxSmall: CGFloat = CGFloat(4)
        public static var xSmall: CGFloat = CGFloat(10)
        public static var small: CGFloat = CGFloat(20)
        public static var medium: CGFloat = CGFloat(30)
        public static var large: CGFloat = CGFloat(40)
        public static var xLarge: CGFloat = CGFloat(80)
        public static var xxLarge = CGFloat(120)
    }
}
