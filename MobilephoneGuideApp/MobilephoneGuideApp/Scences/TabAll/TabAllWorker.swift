//
//  TabAllWorker.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 2/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

import UIKit

protocol TabAllStoreProtocol {
  func feedContent(completion:  @escaping(_ result: Result<[MobileList], Error>) -> Void)
}

class TabAllWorker {
  
  var store: TabAllStoreProtocol
  
  init(store: TabAllStoreProtocol) {
    self.store = store
  }
    //  MARK: - FeedContent
    func feedContent(completion:  @escaping(_ result: Result<[MobileList], Error>) -> Void) {
      store.feedContent { (result) in
        completion(result)
      }
    }
}

enum apiError : Error {
  case runTimeout
}
