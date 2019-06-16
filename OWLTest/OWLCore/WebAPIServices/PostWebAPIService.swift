//
//  PostWebAPIService.swift
//  OWLTest
//
//  Created by Rafael Andres Amezquita Mejia on 6/13/19.
//  Copyright © 2019 Rafael Andres Amezquita Mejia. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkConstants {
  static let baseURL = "https://storage.googleapis.com"
  static let endPoint = "/cdn-og-test-api/test-task/social"
}

class PostWebAPIService {
  
  static func getPosts(from page: Int, completion:@escaping (_ result: Data?)->Void ) {
    let stringURL = "\(NetworkConstants.baseURL)\(NetworkConstants.endPoint)/\(page).json"
    Alamofire.request(stringURL).responseJSON { response in
      if let data = response.data {
        completion(data)
        return
      }
      completion(nil)
    }
  }
}
