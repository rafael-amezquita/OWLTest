//
//  PostsPresenter.swift
//  OWLTest
//
//  Created by Rafael Andres Amezquita Mejia on 6/13/19.
//  Copyright © 2019 Rafael Andres Amezquita Mejia. All rights reserved.
//

import Foundation
import UIKit

class PostsPresenter {
  
  weak var delegate: PostsPresenterDelegate?
  
  private var adapter: PostsAdapter?
  private var postCell: PostTableViewCell?
  private var posts = [Post]()
  private var currentPage: Int
  
  var cellIdentifier: String {
    return postCell?.cellReuseIdentifier ?? ""
  }
  
  var numberOfRows = 0 {
    didSet {
      delegate?.updateTableView()
    }
  }
  
  init() {
    adapter = PostsAdapter()
    postCell = PostTableViewCell()
    currentPage = 0
    configureFeeds()
  }
  
  private func configureFeeds() {
    updatePosts()
  }
  
  func prepare(cell: PostCellProtocol, at index: Int) {
    guard !posts.isEmpty else { return }
    let currentPost = posts[index]
    cell.setup(authorImageURL: currentPost.author.pictureStringURL,
               account: currentPost.author.account ?? "",
               userName: currentPost.author.name,
               network: currentPost.network,
               postText: currentPost.text.plain,
               postImageURLString: currentPost.attachment?.pictureStringURL ?? "",
               date: currentPost.date,
               postImageHeight: currentPost.attachment?.height ?? 0,
               postImageWidth: currentPost.attachment?.width ?? 0)
    
    callNewPageIfNeeded(with: index)
  }
  
  func select(at index: Int) {
    guard !posts.isEmpty else { return }
    
    let post = posts[index]
    if let url = URL(string: post.link),
      UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
  }
  
  private func callNewPageIfNeeded(with index: Int) {
    if index == Int(numberOfRows/2) {
      updatePosts()
    }
  }
  
  private func updatePosts() {
    currentPage += 1
    adapter?.getPosts(from: currentPage) { [weak self] (postsArray) in
      guard let strongSlef = self,
        let posts = postsArray else {
          return
      }
      strongSlef.posts.append(contentsOf: posts)
      strongSlef.numberOfRows = strongSlef.posts.count
      print("CURRENT ROWS: \(strongSlef.numberOfRows)")
    }
  }
  
}
