//
//  DetailWorker.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 2/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

protocol DetailStoreProtocol {
  
}

class DetailWorker {

  var store: DetailStoreProtocol

  init(store: DetailStoreProtocol) {
    self.store = store
  }

  // MARK: - Business Logic
  
  func feedMobileImageUrls(imageID: Int, completion:  @escaping(_ result: [MobileListImage]) -> Void) {
    let baseUrl = "https://scb-test-mobile.herokuapp.com/api/mobiles/\(imageID)/images/"
    AF.request(URL(string: baseUrl)!, method: .get ).responseJSON { response in
      switch response.result {
      case .success(_):
        do {
          let decoder = JSONDecoder()
          let result = try decoder.decode([MobileListImage].self, from: response.data!)
          completion(result)
        } catch let error{
          print(error.localizedDescription)
        }
        break
      case let .failure(error):
          print(error.localizedDescription)
        break
      }
    }
  }
  
  
}
