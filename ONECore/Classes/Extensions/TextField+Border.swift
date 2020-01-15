//
//  TextField+Border.swift
//  ONECore
//
//  Created by DENZA on 25/08/19.
//

import Foundation

extension TextField {
    internal func renderBorder() {
        clearBorder()
        if style.borderStyle == .bezel {
            renderBorderBezel()
            return
        }
        if style.borderStyle == .bottomLine {
            renderBorderBottomLine()
            return
        }
    }

    private func renderBorderBezel() {
        layer.borderColor = style.borderColor.cgColor
        layer.borderWidth = style.borderWidth
        layer.cornerRadius = style.cornerRadius
    }

    private func renderBorderBottomLine() {
        bottomLineLayer.frame = CGRect(
            x: 0,
            y: frame.height - style.borderWidth,
            width: frame.width,
            height: style.borderWidth
        )
        bottomLineLayer.backgroundColor = style.borderColor.cgColor
        if bottomLineLayer.superlayer == nil {
            layer.insertSublayer(bottomLineLayer, at: 0)
        }
    }

    private func clearBorder() {
        borderStyle = style.borderStyle == .bezel ? .roundedRect : .none
        removeBottomLine()
        removeBezelBorder()
    }

    private func removeBottomLine() {
        if bottomLineLayer.superlayer != nil {
            bottomLineLayer.removeFromSuperlayer()
        }
    }

    private func removeBezelBorder() {
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = DefaultValue.emptyCGFloat
        layer.cornerRadius = DefaultValue.emptyCGFloat
    }
}
