//
//  UIView.swift
//  TextViewCell
//

import UIKit

extension UIView {
    func ancestor<View: UIView>(type: View.Type = View.self) -> View? {
        switch superview {
        case .none:
            return .none
        case let superview as View:
            return superview
        case let superview?:
            return superview.ancestor()
        }
    }
}
