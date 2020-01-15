//
//  UIFont+Extension.swift
//  Alamofire
//
//  Created by Sofyan Fradenza Adi on 05/08/19.
//

import Foundation

public extension UIFont {
    private static func registerFont(filename: String, bundle: Bundle?) {
        let token = String(format: DispatchTokenKey.registerFont, filename)
        DispatchQueue.once(token: token) {
            let keys = filename.split(separator: Character(Separator.fileExtension))
            let ext = keys.count > 1
                ? String(keys.last ?? Substring(FileExtension.Font.ttf))
                : FileExtension.Font.ttf
            guard let url = bundle?.url(forResource: filename, withExtension: ext) else { return }
            guard let data = NSData(contentsOf: url) else { return }
            guard let provider = CGDataProvider(data: data) else { return }
            guard let font = CGFont(provider) else { return }
            var error: Unmanaged<CFError>? = nil
            CTFontManagerRegisterGraphicsFont(font, &error)
        }
    }

    static func font(filename: String, size: CGFloat, bundle: Bundle?) -> UIFont {
        UIFont.registerFont(filename: filename, bundle: bundle)
        return UIFont(name: filename, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
