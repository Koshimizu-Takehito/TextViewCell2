//
//  UITableView.swift
//  TextViewCell
//

import UIKit

extension UITableView {
    func indexPath(for subViewOfTableCell: UIView) -> IndexPath? {
        subViewOfTableCell.ancestor().flatMap(indexPath)
    }
}
