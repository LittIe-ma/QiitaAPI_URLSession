//
//  ViewController.swift
//  QiitaAPI-URLSession
//
//  Created by yasudamasato on 2021/12/30.
//

import UIKit

final class ViewController: UIViewController {

  @IBOutlet private weak var tableView: UITableView! {
    didSet {
      tableView.delegate = self
      tableView.dataSource = self
      tableView.register(UINib.init(nibName: TableViewCell.className, bundle: nil), forCellReuseIdentifier: TableViewCell.className)
    }
  }

  private var items: [QiitaArticle] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    fetchQiitaArticles()
  }

  private func fetchQiitaArticles() {
    QiitaAPI.shared.get { result in
      DispatchQueue.main.async {
        switch result {
        case .failure(let error):
          print(error.localizedDescription)
        case .success(let items):
          self.items = items
          self.tableView.reloadData()
        }
      }
    }
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    45
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.className) as? TableViewCell else {
      fatalError()
    }
    let qiitaRepository = items[indexPath.row]
    cell.configure(item: qiitaRepository)
    return cell
  }
}
