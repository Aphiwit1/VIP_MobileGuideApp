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
  func getData(_ completion: @escaping (Result<Entity>) -> Void)
}

class DetailWorker {

  var store: DetailStoreProtocol

  init(store: DetailStoreProtocol) {
    self.store = store
  }

  // MARK: - Business Logic

  func doSomeWork(_ completion: @escaping (Result<Entity>) -> Void) {
    // NOTE: Do the work
    store.getData {
      // The worker may perform some small business logic before returning the result to the Interactor
      completion($0)
    }
  }
  
  func feedMobileImageUrls(imageID: Int, completion:  @escaping(_ result: [MobileListImage]) -> Void) {
    let baseUrl = "https://scb-test-mobile.herokuapp.com/api/mobiles/\(imageID)/images/"
    AF.request(URL(string: baseUrl)!, method: .get ).responseJSON { response in
      print(response)
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
