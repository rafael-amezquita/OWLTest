//
//  PostsAdapter.swift
//  OWLTest
//
//  Created by Rafael Andres Amezquita Mejia on 6/13/19.
//  Copyright © 2019 Rafael Andres Amezquita Mejia. All rights reserved.
//

import Foundation

class PostsAdapter {
  
  func getPosts(from page: Int, completion:@escaping ([Post]?)->Void) {
    PostWebAPIService.getPosts(from: page) {(response) in
      var feeds: [Post]?
      
      guard let data = response else { return }

      do {
        let decoder = JSONDecoder()
        feeds = try decoder.decode([Post].self, from: data)
      } catch {
        print("\(error.localizedDescription)")
      }
      
      completion(feeds)
    }
  }
}
