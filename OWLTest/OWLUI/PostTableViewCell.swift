//
//  PostTableViewCell.swift
//  OWLTest
//
//  Created by Rafael Andres Amezquita Mejia on 6/13/19.
//  Copyright © 2019 Rafael Andres Amezquita Mejia. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
  
  @IBOutlet weak var authorImageView: UIImageView!
  @IBOutlet weak var accountLabel: UILabel!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var networkImageView: UIImageView!
  @IBOutlet weak var postTextView: UITextView!
  @IBOutlet weak var postImageView: UIImageView!
  @IBOutlet weak var dateLabel: UILabel!
  
  @IBOutlet weak var postImageViewHeightConstraint: NSLayoutConstraint!
  
  private enum SocialNetwork: String {
    case facebook = "facebook"
    case twitter = "twitter"
  }
  
  fileprivate func configurePostImage(from stringURL: String,
                                      width: Int,
                                      height: Int) {
    guard height > 0 else { return }
    configure(imageView: postImageView, from: stringURL) { (isSuccesful) in
      if isSuccesful {
        self.postImageViewHeightConstraint.constant = CGFloat((height/width) * 320)
      }
    }
  }
  
  fileprivate func configureAuthorImage(from stringURL: String) {
    configure(imageView: authorImageView, from: stringURL, completion: nil)
  }
  
  private func configure(imageView: UIImageView,
                         from stringURL: String,
                         completion: ((Bool)->Void)?) {
    guard let url = URL(string: stringURL)  else { return }
    
    let task = URLSession.shared.dataTask(with: url) { (responseData, response, error) in
      guard let data = responseData,
        let httpResponse = response as? HTTPURLResponse,
        // NOTE: For most of the images this is returning "URL signature expired"
        httpResponse.statusCode != 403 else {
          completion?(false)
          return
      }
      DispatchQueue.main.async {
        guard let image = UIImage(data: data) else {
          completion?(false)
          return
        }
        imageView.image = image
        completion?(true)
      }
    }
    
    task.resume()
  }
  
  fileprivate func formatDate(from string: String) -> String {
    var stringDate = ""
    let dateFormatterReceived = DateFormatter()
    let dateFormatterToRetrieve = DateFormatter()
    
    dateFormatterReceived.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    dateFormatterToRetrieve.dateFormat = "MMM yyyy hh:mm a"
    
    if let date = dateFormatterReceived.date(from: string) {
      stringDate = dateFormatterToRetrieve.string(from: date)
    }
    return stringDate
  }
  
}

extension PostTableViewCell: PostCellProtocol {
  func setup(authorImageURL: String,
             account: String,
             userName: String,
             network: String,
             postText: String,
             postImageURLString: String,
             date: String,
             postImageHeight: Int,
             postImageWidth: Int) {
    accountLabel.text = account.isEmpty ? account : "@\(account)"
    userNameLabel.text = userName
    postTextView.text = postText
    dateLabel.text = formatDate(from: date)
    configurePostImage(from: postImageURLString,
                       width: postImageWidth,
                       height: postImageHeight)
    configureAuthorImage(from: authorImageURL)
    networkImageView.image = UIImage(named: "\(network)_icon")
    postTextView.sizeToFit()
    postImageView.sizeToFit()
  }
}

extension PostTableViewCell: GeneralCellProtocol {
  var cellReuseIdentifier: String {
    return "PostTableViewCell"
  }
  
  var nibName: String {
    return "PostTableViewCell"
  }
}
