//
//  CGFloat.swift
//  TextViewCell
//

import UIKit

extension CGFloat {
    func roundedNativeScale() -> CGFloat {
        let abs = Swift.abs(self)
        let bound = (lower: abs.rounded(.down), upper: abs.rounded(.up))
        let tick = 1/UIScreen.main.nativeScale
        var value = bound.lower
        while self > value { value += tick }
        return Swift.min(value, bound.upper)
    }
}
