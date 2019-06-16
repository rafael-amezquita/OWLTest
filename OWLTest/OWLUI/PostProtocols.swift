//
//  PostProtocols.swift
//  OWLTest
//
//  Created by Rafael Andres Amezquita Mejia on 6/14/19.
//  Copyright © 2019 Rafael Andres Amezquita Mejia. All rights reserved.
//

import Foundation
import UIKit

protocol PostCellProtocol {
  func setup(authorImageURL: String,
             account: String,
             userName: String,
             network: String,
             postText: String,
             postImageURLString: String,
             date: String,
             postImageHeight: Int,
             postImageWidth: Int)
}

protocol GeneralCellProtocol: class {
  var cellReuseIdentifier: String { get }
  var nibName: String { get }
}

protocol PostsPresenterDelegate: class {
  func updateTableView()
}

protocol CellRegistrable {
  func register<T: GeneralCellProtocol>(cell: T, inTableView tableView: UITableView)
}

extension CellRegistrable {
  func register<T: GeneralCellProtocol>(cell: T, inTableView tableView: UITableView) {
    let bundle = Bundle(for: T.self)
    let nibFile = UINib(nibName: cell.nibName, bundle: bundle)
    tableView.register(nibFile, forCellReuseIdentifier: cell.cellReuseIdentifier)
  }
}
