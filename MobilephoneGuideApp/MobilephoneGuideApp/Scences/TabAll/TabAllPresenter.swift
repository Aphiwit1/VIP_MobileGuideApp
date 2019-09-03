//
//  TabAllPresenter.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 2/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

import UIKit

protocol TabAllPresenterInterface {
  func presentData(response: TabAll.FeedDataTable.Response)
  func presentDataFavourite(response: TabAll.SetFavData.Response)
  func presentFavouriteTab(response: TabAll.ShowFavouritesTab.Response)
}

class TabAllPresenter: TabAllPresenterInterface {
  
  
 
    weak var viewController: TabAllViewControllerInterface!

    
    func presentData(response: TabAll.FeedDataTable.Response) {
      
        let displayMobileList = response.mobileListModel.map {
            TabAll.DisplayMobile(
              mobileID: $0.id,
              mobilename: $0.name,
              mobileRating: "Rating: $\(String($0.rating))",
              mobilePrice: "Price: $\(String($0.price))",
              mobileDescription: $0.description,
              mobileImage: $0.thumbImageURL,
              isFav: $0.favSelected ?? false
            )
        }
        let mobileViewModel = TabAll.FeedDataTable.ViewModel(
            displayMobileList: displayMobileList
        )
        viewController.displayResultData(viewModel: mobileViewModel)
    }
  
  func presentDataFavourite(response: TabAll.SetFavData.Response) {
    let displayFavList = response.mobileListModel.map {
      TabAll.DisplayMobile(
        mobileID: $0.id,
        mobilename: $0.name,
        mobileRating: "Rating: $\(String($0.rating))",
        mobilePrice: "Price: $\(String($0.price))",
        mobileDescription: $0.description,
        mobileImage: $0.thumbImageURL,
        isFav: $0.favSelected ?? false
      )
    }
//    let mobileFavList = TabAll.SetFavData.ViewModel(mobileFavList: displayFavList)
//    viewController.displayFavouriteTab(viewModel: mobileFavList)
  }
  
  func presentFavouriteTab(response: TabAll.ShowFavouritesTab.Response) {
    let displayFavList = response.mobileListModel.map {
      TabAll.DisplayMobile(
        mobileID: $0.id,
        mobilename: $0.name,
        mobileRating: "Rating: $\(String($0.rating))",
        mobilePrice: "Price: $\(String($0.price))",
        mobileDescription: $0.description,
        mobileImage: $0.thumbImageURL,
        isFav: $0.favSelected ?? false
      )
    }
    let mobileFavList = TabAll.ShowFavouritesTab.ViewModel(mobileFavList: displayFavList)
    viewController.displayFavouriteTab(viewModel: mobileFavList)
  }
  
}
