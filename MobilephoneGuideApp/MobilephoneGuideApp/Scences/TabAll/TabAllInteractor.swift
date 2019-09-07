//
//  TabAllInteractor.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 2/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

import UIKit

protocol TabAllInteractorInterface {
  func fetchMobileList(request: TabAll.FeedDataTable.Request)
  func setFavourite(request: TabAll.SetFavData.Request)
  func getFavouriteMobiles(request: TabAll.ShowFavouritesTab.Request)
  func getAllMobiles(request: TabAll.ShowAllTab.Request)
  func getSorting(request: TabAll.SortTable.Request)
}

class TabAllInteractor: TabAllInteractorInterface {
  
  var dataArray: [MobileList] = []
  var presenter: TabAllPresenterInterface!
  var worker: TabAllWorker?
  
  // MARK: - Business logic=
  func fetchMobileList(request: TabAll.FeedDataTable.Request) {
    worker?.feedContent(completion: { (result) in
      switch result {
      case let .success(data):
        let response = TabAll.FeedDataTable.Response(mobileListModel: .success(data))
        self.presenter.presentData(response: response)
        self.dataArray = data
      case let .failure(error):
        let response = TabAll.FeedDataTable.Response(mobileListModel: .failure(error))
        self.presenter.presentData(response: response)
      }
    })
  }
  
  func setFavourite(request: TabAll.SetFavData.Request) {
    for i in dataArray {
      if i.id == request.mobileID {
        i.favSelected = request.isFav
      }
    }
  }

  func getFavouriteMobiles(request: TabAll.ShowFavouritesTab.Request) {
    let favourites = dataArray.filter { $0.favSelected ?? false  }
    let response = TabAll.ShowFavouritesTab.Response(mobileListModel: favourites)
    presenter.presentFavouriteTab(response: response)
  }
  
  func getAllMobiles(request: TabAll.ShowAllTab.Request) {
    let response = TabAll.ShowAllTab.Response(mobileListModel: dataArray)
    presenter.presentAllTab(response: response)
  }
  
  func getSorting(request: TabAll.SortTable.Request) {
    switch request.sortType {
    case .PriceHightToLow :
//     dataArray.sort { $0.price > $1.price }
      dataArray.sort { (first: MobileList,second: MobileList) -> Bool in
        first.price > second.price
      }
    case .PriceLowToHight :
      dataArray.sort { (first: MobileList,second: MobileList) -> Bool in
        first.price < second.price
      }
    case .RatingHightToLow :
      dataArray.sort { (first: MobileList,second: MobileList) -> Bool in
        first.rating > second.rating
      }
    }
    
    if request.BtntagSelected == 0 {
      let response = TabAll.FeedDataTable.Response(mobileListModel:.success(dataArray))
      presenter.presentData(response: response)
    }else if request.BtntagSelected == 1 {
      let dataArrayForFavourite = dataArray.filter() {
         $0.favSelected ?? false
      }
      let response = TabAll.ShowFavouritesTab.Response(mobileListModel: dataArrayForFavourite)
      presenter.presentFavouriteTab(response: response)
    }
  }
}

