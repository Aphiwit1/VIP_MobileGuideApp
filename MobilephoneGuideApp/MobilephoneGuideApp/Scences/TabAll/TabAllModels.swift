//
//  TabAllModels.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 2/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

import UIKit

struct TabAll {
  
  struct DisplayMobile {
    let mobileID: Int
    let mobilename : String
    let mobileRating : String
    let mobilePrice  : String
    let mobileDescription  : String
    let mobileImage: String
    let isFav : Bool
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
      
     
    }
  }
  
  
  
  struct SortTable {
    /// Data struct sent to Interactor
    struct Request {
      enum sortTyle {
        case PriceHightToLow
        case PriceLowToHight
        case RatingHightToLow
      }
    }
    /// Data struct sent to Presenter
    struct Response {
      
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      
      var mobileSortTyle : [ DisplayMobile ]
      
    }
  }

  struct SetFavData {
    /// Data struct sent to Interactor
    struct Request {
      let mobileID: Int
      let isFav: Bool
    }
    /// Data struct sent to Presenter
    struct Response {
      var mobileListModel: [MobileList]
    }
    
    struct ViewModel {
      var mobileFavList: [ DisplayMobile ]
      
     
    }
  }
  
  struct ShowFavouritesTab {
    struct Request {}
    
    struct Response {
      var mobileListModel: [MobileList]
    }
    
    struct ViewModel {
      var mobileFavList: [ DisplayMobile ]
    }
  }
}

