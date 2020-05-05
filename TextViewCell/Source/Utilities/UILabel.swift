//
//  UILabel.swift
//  TextViewCell
//

import UIKit

@IBDesignable
final class Label: UILabel {

    @IBInspectable var monospaced: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }

    private func setup() {
        if monospaced {
            font = font?.monospacedDigit()
        }
    }
}
