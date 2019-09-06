//
//  TabAllStore.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 2/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class TabAllStore: TabAllStoreProtocol {
  func feedContent(completion: @escaping (Result<[MobileList], Error>) -> Void) {
    let baseUrl = "https://scb-test-mobile.herokuapp.com/api/mobiles"
    AF.request(baseUrl).response { (response) in
      
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
