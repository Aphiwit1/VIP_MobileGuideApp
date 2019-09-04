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
    
    struct Request {}
    
    struct Response {
      var mobileListModel: [MobileList]
    }
    struct ViewModel {
      var displayMobileList : [ DisplayMobile ]
    }
  }
  
  
  
  struct SortTable {
    
    struct Request {
      enum sortTyle {
        case PriceHightToLow
        case PriceLowToHight
        case RatingHightToLow
      }
      let sortType:sortTyle
      let tagSort: Int
    }
    
    struct Response {}
    
    struct ViewModel {
      var mobileSortTyle : [ DisplayMobile ]
      
    }
  }
  
  class SetFavData {
    
    struct Request {
      let mobileID: Int
      let isFav: Bool
    }
    
    struct Response {
      var mobileListModel: [MobileList]
    }
    
    struct ViewModel {
      var mobileFavList: [ DisplayMobile ]
      
      
    }
  }
  
  class ShowFavouritesTab {
    struct Request {}
    
    struct Response {
      var mobileListModel: [MobileList]
    }
    
    struct ViewModel {
      var mobileFavList: [ DisplayMobile ]
    }
  }
  
  class ShowAllTab {
    struct Request {}
    
    struct Response {
      var mobileListModel: [MobileList]
    }
    
    struct ViewModel {
      var mobileFavList: [ DisplayMobile ]
    }
  }
  
  
}

