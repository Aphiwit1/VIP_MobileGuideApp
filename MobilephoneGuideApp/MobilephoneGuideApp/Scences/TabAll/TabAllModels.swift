//
//  TabAllModels.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 2/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

import UIKit

struct TabAll {
  /// This structure represents a use case
  struct Something {
    /// Data struct sent to Interactor
    struct Request {}
    /// Data struct sent to Presenter
    struct Response {}
    /// Data struct sent to ViewController
    struct ViewModel {
        
    }
  }
    
    struct FeedDataTable {
        /// Data struct sent to Interactor
        struct Request {}
        /// Data struct sent to Presenter
        struct Response {
            var mobileListModel: [MobileList]
        }
        /// Data struct sent to ViewController
        struct ViewModel {
           // var mobileListModel: [MobileList]le
            
            var displayMobileList : [ DisplayMobile ]
        
            struct DisplayMobile {
                let mobilename : String
                let mobileRating : String
                let mobilePrice  : String
                let mobileDescription  : String
                let mobileImage: String
            }
        }
    }
    
}
