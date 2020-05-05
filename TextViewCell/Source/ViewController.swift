//
//  ViewController.swift
//  TextView
//

import UIKit

final class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    // MARK: - Property
    @IBOutlet private weak var tableView: UITableView!
    /// サンプルのリスト
    private var items: [SampleItem] = .samples

    private var cacheHeights: [IndexPath: CGFloat] = [:]

    /// 処理直列化のための非メインQueue
    private let serialQueue = DispatchQueue(label: "com.example.TextViewCell.ViewController.serialQueue")

    // MARK: - Managing the View
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuideNoSafeArea.topAnchor).isActive = true
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        switch tableView.dequeueReusableCell(withIdentifier: String(describing: type(of: item)), for: indexPath) {
        case let cell as SampleItemCell:
            (cell.label.text, cell.textView.text, cell.textView.delegate) = (item.row, item.text, self)
            return cell

        case let cell:
            return cell
        }
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        cacheHeights[indexPath] ?? { [width = UIScreen.main.bounds.width] in
            let value = cellHeight(with: items[indexPath.row], contentWidth: width)
            cacheHeights[indexPath] = value
            return value
        }()
    }

    // MARK: - UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        let indexPath = tableView.indexPath(for: textView)!

        serialQueue.async { [text = textView.text!, width = tableView.bounds.width] in
            self.items[indexPath.row].text = text
            let newHeight = cellHeight(with: self.items[indexPath.row], contentWidth: width)
            let oldHeight = self.cacheHeights[indexPath]

            if oldHeight != newHeight {
                self.cacheHeights[indexPath] = newHeight
                DispatchQueue.main.async {
                    UIView.performWithoutAnimation {
                        self.tableView.performBatchUpdates(nil)
                    }
                }
            }
        }
    }
}

// MARK: - Private
@inline(__always)
private func cellHeight(with item: SampleItem, contentWidth width: CGFloat) -> CGFloat {
    /// 余白
    let spacing: (vertical: CGFloat, horizontal: CGFloat) = (22, 45)

    /// 「第 XX 段落」の矩形
    let paragraph = NSAttributedString(string: item.row, attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .bold).monospacedDigit()])
        .boundingRect(
            with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            context: nil
    )

    /// 「本文」の矩形
    let body = NSAttributedString(string: item.text, attributes: [.font: UIFont.systemFont(ofSize: 17)])
        .boundingRect(
            with: CGSize(width: width - (paragraph.width.roundedNativeScale() + spacing.horizontal), height: CGFloat.greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            context: nil
    )

    // テキストのサイズは物理ピクセルを考慮して丸めておく
    return body.height.roundedNativeScale() + spacing.vertical
}
