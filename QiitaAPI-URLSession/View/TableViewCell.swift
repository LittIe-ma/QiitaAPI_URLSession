//
//  TableViewCell.swift
//  QiitaAPI-URLSession
//
//  Created by yasudamasato on 2021/12/30.
//

import UIKit

final class TableViewCell: UITableViewCell {

  @IBOutlet private weak var label: UILabel!

  static var className: String { String(describing: TableViewCell.self) }

  override func prepareForReuse() {
    super.prepareForReuse()
    label.text = nil
  }

  func configure(item: QiitaArticle) {
    label.text = item.title
  }
}
