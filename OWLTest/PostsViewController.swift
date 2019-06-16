//
//  PostsViewController.swift
//  OWLTest
//
//  Created by Rafael Andres Amezquita Mejia on 6/13/19.
//  Copyright © 2019 Rafael Andres Amezquita Mejia. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController, CellRegistrable {
  
  @IBOutlet weak var tableView: UITableView!
  
  fileprivate var presenter: PostsPresenter?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter = PostsPresenter()
    presenter?.delegate = self
    configureTableView()
  }
  
  private func configureTableView() {
    register(cell: PostTableViewCell(), inTableView: tableView)
  }
  
}

extension PostsViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 350
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter?.select(at: indexPath.row)
  }
  
}

extension PostsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter?.numberOfRows ?? 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let presenter = self.presenter else { return UITableViewCell() }
    
    let feedCell = tableView.dequeueReusableCell(withIdentifier: presenter.cellIdentifier, for: indexPath)
    if let cell = feedCell as? PostCellProtocol {
      presenter.prepare(cell: cell, at: indexPath.row)
    }
    return feedCell
  }

}

extension PostsViewController: PostsPresenterDelegate {
  func updateTableView() {
    tableView.reloadData()
  }
}


