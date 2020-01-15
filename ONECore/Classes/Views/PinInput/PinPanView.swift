//
//  PinView.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 20/09/19.
//

import UIKit

class PinPanView: View {
    private var pinLabel: UILabel = UILabel()
    private var bottomLineView: View = View()
    private var value: String = DefaultValue.emptyString {
        didSet {
            pinLabel.text = value
        }
    }
    private var style: PinInputStyle = DefaultPinInputStyle()

    private func renderContainerStyle() {
        backgroundColor = style.backgroundColor
        setRoundedCorners(radius: style.cornerRadius)
        applyBorder(color: style.borderColor, width: style.borderWidth)
    }

    private func renderPinLabel() {
        pinLabel.frame = bounds
        pinLabel.font = style.font
        pinLabel.textColor = style.textColor
        pinLabel.backgroundColor = .clear
        pinLabel.textAlignment = .center
        pinLabel.text = DefaultValue.emptyString
        addSubview(pinLabel)
    }

    private func renderBottomLine() {
        if style.bottomLineWidth <= DefaultValue.emptyCGFloat { return }
        bottomLineView.frame = bounds
        bottomLineView.frame.size.height = style.bottomLineWidth
        bottomLineView.frame.origin.y = bounds.size.height - bottomLineView.frame.size.height
        bottomLineView.backgroundColor = style.bottomLineColor
        addSubview(bottomLineView)
    }

    public func getValue() -> String {
        return value
    }

    public func setValue(_ value: String) {
        if self.value != DefaultValue.emptyString { return }
        if value.count != 1 { return }
        self.value = value
    }

    public func resetValue() {
        value = DefaultValue.emptyString
    }

    public func isEmpty() -> Bool {
        return value == DefaultValue.emptyString
    }

    public func updateValue(_ value: String) {
        resetValue()
        setValue(value)
    }

    func render(style: PinInputStyle) {
        self.style = style
        removeAllSubviews()
        renderContainerStyle()
        renderPinLabel()
        renderBottomLine()
    }
}
