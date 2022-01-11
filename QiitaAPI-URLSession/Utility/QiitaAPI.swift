//
//  QiitaAPI.swift
//  QiitaAPI-URLSession
//
//  Created by yasudamasato on 2021/12/30.
//

import Foundation

enum QiitaError: Error {
  case error
}

final class QiitaAPI {
  static let shared = QiitaAPI()
  private init() {}

  func get(completion: ((Result<[QiitaArticle], QiitaError>) -> Void)? = nil) {
    let url = URL(string: "https://qiita.com/api/v2/items")!
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard
        let data = data,
        let qiitaResponse = try? JSONDecoder().decode([QiitaArticle].self, from: data)
      else {
        if let error = error {
          print(error)
        }
        completion?(.failure(.error))
        return
      }
      completion?(.success(qiitaResponse))
    }
    task.resume()
  }
}
