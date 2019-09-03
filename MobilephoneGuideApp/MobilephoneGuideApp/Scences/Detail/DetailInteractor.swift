//
//  DetailInteractor.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 2/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

import UIKit

protocol DetailInteractorInterface {

  func setUpUI(request: Detail.Something.Request)
  var mobileDetail : TabAll.FeedDataTable.ViewModel.DisplayMobile? {get set}
  func doFeedImageURLs(request: Detail.GetImage.Request)

}

class DetailInteractor: DetailInteractorInterface {

  var mobileDetail: TabAll.FeedDataTable.ViewModel.DisplayMobile?
  var presenter: DetailPresenterInterface!
  var worker: DetailWorker?

  func setUpUI(request: Detail.Something.Request) {
//      let response = Detail.Something.Response()
      
  }
  
  func doFeedImageURLs(request: Detail.GetImage.Request) {
    worker?.feedMobileImageUrls(imageID: mobileDetail?.mobileID ?? 1, completion: { (imageResult) in
         let response = Detail.GetImage.Response(imageURLs: imageResult)
      self.presenter.presentImageData(response: response)
    })
  }
  
 
  
  
}
