//
//  UIFont.swift
//  TextViewCell
//

import UIKit

extension UIFont {
    var weight: UIFont.Weight {
        let traits = CTFontCopyTraits(self as CTFont) as Dictionary
        if let weight = traits[kCTFontWeightTrait] as? NSNumber {
            return UIFont.Weight(CGFloat(weight.doubleValue))
        } else {
            return .regular
        }
    }

    func monospacedDigit() -> UIFont {
        UIFont.monospacedDigitSystemFont(ofSize: pointSize, weight: weight)
    }
}
