//
//  ViewController.swift
//  TextView
//

import UIKit

final class SampleItemCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: UITextView!
}

final class ViewController: UIViewController, UITableViewDataSource {
    /// サンプルのリスト
    private let items: [SampleItem] = .samples

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        switch tableView.dequeueReusableCell(withIdentifier: String(describing: type(of: item)), for: indexPath) {
        case let cell as SampleItemCell:
            cell.label.text = item.row
            cell.textView.text = item.text
            return cell

        case let cell:
            return cell
        }
    }
}
