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
  func presentAllTab(response: TabAll.ShowAllTab.Response)
}
class TabAllPresenter: TabAllPresenterInterface {
    weak var viewController: TabAllViewControllerInterface!
    func presentData(response: TabAll.FeedDataTable.Response) {
      switch response.mobileListModel {
      case let .success(data):
        let displayMobileList = data.map {
          TabAll.DisplayMobile(
            mobileID: $0.id,
            mobilename: $0.name,
            mobileRating: "Rating: \(String($0.rating))",
            mobilePrice: "Price: $\(String($0.price))",
            mobileDescription: $0.description,
            mobileImage: $0.thumbImageURL,
            isFav: $0.favSelected ?? false
          )
        }
        let mobileViewModel = TabAll.FeedDataTable.ViewModel(
          displayMobileList: .success(displayMobileList)
        )
        viewController.displayResultData(viewModel: mobileViewModel)
      case let .failure(error):
        let mobileViewModel = TabAll.FeedDataTable.ViewModel(
          displayMobileList: .failure(error)
        )
        viewController.displayResultData(viewModel: mobileViewModel)
      }
      
    }
  
  func presentDataFavourite(response: TabAll.SetFavData.Response) {
  }
  
  func presentFavouriteTab(response: TabAll.ShowFavouritesTab.Response) {
    let displayFavList = response.mobileListModel.map {
      TabAll.DisplayMobile(
        mobileID: $0.id,
        mobilename: $0.name,
        mobileRating: "Rating: \(String($0.rating))",
        mobilePrice: "Price: $\(String($0.price))",
        mobileDescription: $0.description,
        mobileImage: $0.thumbImageURL,
        isFav: $0.favSelected ?? false
      )
    }
    let mobileFavList = TabAll.ShowFavouritesTab.ViewModel(mobileFavList: displayFavList)
    viewController.displayFavouriteTab(viewModel: mobileFavList)
  }

  func presentAllTab(response: TabAll.ShowAllTab.Response) {
    let displayAllList = response.mobileListModel.map {
      TabAll.DisplayMobile(
        mobileID: $0.id,
        mobilename: $0.name,
        mobileRating: "Rating: \(String($0.rating))",
        mobilePrice: "Price: $\(String($0.price))",
        mobileDescription: $0.description,
        mobileImage: $0.thumbImageURL,
        isFav: $0.favSelected ?? false
      )
    }
    let mobileAllList = TabAll.ShowAllTab.ViewModel(mobileFavList: displayAllList)
    viewController.displayAllTab(viewModel: mobileAllList)
  }
  
}
