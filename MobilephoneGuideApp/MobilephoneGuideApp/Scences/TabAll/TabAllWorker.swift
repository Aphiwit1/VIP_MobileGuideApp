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
//  func feedContent(completion:  @escaping(_ result: Swift.Result<[MobileList],Error>) -> Void)
}

class TabAllWorker {

  var store: TabAllStoreProtocol

  init(store: TabAllStoreProtocol) {
    self.store = store
  }

    
    //  MARK: - FeedContent
    func feedContent(completion:  @escaping(_ result: Swift.Result<[MobileList],Error>) -> Void) {
        let baseUrl = "https://scb-test-mobile.herokuapp.com/api/mobiles"
        AF.request(baseUrl).response { (response) in
          
          
//            do {
//                let decoder = JSONDecoder()
//                let result = try decoder.decode([MobileList].self, from: response.data!)
//                completion(.success(result))
//            }catch {
//                completion(.failure(error))
//                print(error.localizedDescription)
//            }
          
          switch response.result {
          case .success:
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode([MobileList].self, from: response.data!)
                completion(.success(result))
            }catch {
                completion(.failure(error))
            }
          case let .failure(error):
            completion(.failure(error))
          }
          
        }
    }
}
