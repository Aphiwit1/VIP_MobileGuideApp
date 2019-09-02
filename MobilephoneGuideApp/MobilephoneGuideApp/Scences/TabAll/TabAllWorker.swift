//
//  TabAllWorker.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 2/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

protocol TabAllStoreProtocol {
  func getData(_ completion: @escaping (Result<Entity>) -> Void)
}

class TabAllWorker {

  var store: TabAllStoreProtocol

  init(store: TabAllStoreProtocol) {
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
    
    //  MARK: - FeedContent
    func feedContent(completion:  @escaping(_ result: [MobileList]) -> Void) {
        let baseUrl = "https://scb-test-mobile.herokuapp.com/api/mobiles"
        AF.request(baseUrl).response { (response) in
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode([MobileList].self, from: response.data!)
                completion(result)
            }catch {
                print("---error --->", error.localizedDescription)
            }
        }
    }
}
