//
//  OWLDataModel.swift
//  OWLTest
//
//  Created by Rafael Andres Amezquita Mejia on 6/13/19.
//  Copyright © 2019 Rafael Andres Amezquita Mejia. All rights reserved.
//

import Foundation

/*
{
  "author": {},
  "date": "2019-02-12T09:25:34+00:00",
  "link": "https://www.facebook.com/113384688696056/posts/2329966410371195/",
  "text": {},
  "attachment": {},
  "network": "facebook"
}
*/
struct Post: Codable {
  
  var author: Author
  var date: String
  var link: String
  var text: Text
  var attachment: Attachement?
  var network: String
  
  enum FeedKeys: String, CodingKey {
    case author
    case date
    case link
    case text
    case attachment
    case network
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: FeedKeys.self)
    author = try values.decode(Author.self, forKey: .author)
    date = try values.decode(String.self, forKey: .date)
    link = try values.decode(String.self, forKey: .link)
    text = try values.decode(Text.self, forKey: .text)
    if let attachementObject = try? values.decode(Attachement.self, forKey: .attachment) {
      attachment = attachementObject
    }
    network = try values.decode(String.self, forKey: .network)
  }
  
  func encode(to encoder: Encoder) throws {
    var values = encoder.container(keyedBy: FeedKeys.self)
    try values.encode(author, forKey: .author)
    try values.encode(date, forKey: .date)
    try values.encode(link, forKey: .link)
    try values.encode(text, forKey: .text)
    try? values.encode(attachment, forKey: .attachment)
    try values.encode(network, forKey: .network)
  }
}

/*
{
  "is-verified": false,
  "name": "FINA",
  "picture-link": "https://scontent.xx.fbcdn.net/v/t1.0-1/p50x50/49705048_2267931836574653_2128693900519407616_n.png?_nc_cat=109&_nc_ht=scontent.xx&oh=07dd619c21438a0c0c45b0c3b1c535e8&oe=5CDBA36B"
}
*/
struct Author: Codable {
  var account: String?
  var isVerified: Bool
  var name: String
  var pictureStringURL: String
  
  enum AuthorKeys: String, CodingKey {
    case account
    case isVerified = "is-verified"
    case name
    case pictureStringURL = "picture-link"
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: AuthorKeys.self)
    if let accountString = try? values.decode(String.self, forKey: .account) {
      account = accountString
    }
    isVerified = try values.decode(Bool.self, forKey: .isVerified)
    name = try values.decode(String.self, forKey: .name)
    pictureStringURL = try values.decode(String.self, forKey: .pictureStringURL)
  }
  
  func encode(to encoder: Encoder) throws {
    var values = encoder.container(keyedBy: AuthorKeys.self)
    try? values.encode(account, forKey: .account)
    try values.encode(isVerified, forKey: .isVerified)
    try values.encode(name, forKey: .name)
    try values.encode(pictureStringURL, forKey: .pictureStringURL)
  }
}

/*
{
  "markup": [{},{},{},{}],
  "plain": "Our ladies are back in the pool today, for Game Day 9, Women's Water Polo World League 2019, Euro Preliminaries! \ud83e\udd3d\ud83c\udffb\u200d\u2640\ufe0f \nReady to follow the action on \ud83d\udcfa FINAtv.live? \n\n#FINA #FINAtv #WaterPolo #WPWL19"
}
*/
struct Text: Codable {
  var markup: [Markup]
  var plain: String
}

/*
 {
   "length": 5,
   "location": 167,
   "link": "https://www.facebook.com/hashtag/FINA"
 }
*/
struct Markup: Codable {
  var length: Int
  var location: Int
  var link: String
}

/*
 {
   "picture-link": "https://scontent.xx.fbcdn.net/v/t1.0-9/s720x720/51747373_2329966287037874_4922398362235305984_o.jpg?_nc_cat=104&_nc_ht=scontent.xx&oh=e020141444fb60be7b480b69cace83db&oe=5CEE40DA",
   "width": 720,
   "height": 360
 }
*/
struct Attachement: Codable {
  var pictureStringURL: String
  var width: Int
  var height: Int
  
  enum AttachementKeys: String, CodingKey {
    case pictureStringURL = "picture-link"
    case width
    case height
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: AttachementKeys.self)
    pictureStringURL = try values.decode(String.self, forKey: .pictureStringURL)
    width = try values.decode(Int.self, forKey: .width)
    height = try values.decode(Int.self, forKey: .height)
  }
  
  func encode(to encoder: Encoder) throws {
    var values = encoder.container(keyedBy: AttachementKeys.self)
    try values.encode(pictureStringURL, forKey: .pictureStringURL)
    try values.encode(width, forKey: .width)
    try values.encode(height, forKey: .height)
  }
}
