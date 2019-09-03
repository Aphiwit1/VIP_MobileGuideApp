//
//  DetailModels.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 2/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

import UIKit

struct Detail {
  /// This structure represents a use case
  struct Something {
    /// Data struct sent to Interactor
    struct Request {}
    /// Data struct sent to Presenter
    struct Response {}
    /// Data struct sent to ViewController
    struct ViewModel {}
  }
  
  struct ShowDetail {
    /// Data struct sent to Interactor
    struct Request {}
    /// Data struct sent to Presenter
    struct Response {
       var displayMobile :  TabAll.DisplayMobile
    }
    
    /// Data struct sent to ViewController
    struct ViewModel {
      var displayMobile :  DisplayMobile
      struct DisplayMobile {
        let mobileID: Int
        let mobilename : String
        let mobileRating : String
        let mobilePrice  : String
        let mobileDescription  : String
        let mobileImage: String
      }
    }
  }
  
  struct GetImage {
    /// Data struct sent to Interactor
    struct Request { }
    
    struct Response {
      let imageURLs: [MobileListImage]
    }
    
    struct ViewModel {
      struct MobileImage {
        var url : String
      }
      var mobileImages : [MobileImage]
  }
    
  }
  
}
