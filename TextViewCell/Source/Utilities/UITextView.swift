//
//  UITextView.swift
//  TextViewCell
//

import UIKit

@IBDesignable
final class TextView: UITextView {
    @IBInspectable var insetTop: CGFloat {
        get { textContainerInset.top }
        set { textContainerInset.top = newValue }
    }
    @IBInspectable var insetRight: CGFloat {
        get { textContainerInset.right }
        set { textContainerInset.right = newValue }
    }
    @IBInspectable var insetBottom: CGFloat {
        get { textContainerInset.bottom }
        set { textContainerInset.bottom = newValue }
    }
    @IBInspectable var insetLeft: CGFloat {
        get { textContainerInset.left }
        set { textContainerInset.left = newValue }
    }

    @IBInspectable var lineFragmentPadding: CGFloat {
        get { textContainer.lineFragmentPadding }
        set { textContainer.lineFragmentPadding = newValue }
    }
}
