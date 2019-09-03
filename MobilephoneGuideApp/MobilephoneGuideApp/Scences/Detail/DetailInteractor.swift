//
//  DetailInteractor.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 2/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

import UIKit

protocol DetailInteractorInterface {

  func setUpUI(request: Detail.ShowDetail.Request)
  func doFeedImageURLs(request: Detail.GetImage.Request)
  
  var mobileDetail : TabAll.DisplayMobile? {get set}

}

class DetailInteractor: DetailInteractorInterface {

  var mobileDetail: TabAll.DisplayMobile?
  var presenter: DetailPresenterInterface!
  var worker: DetailWorker?

  func setUpUI(request: Detail.ShowDetail.Request) {
    let response = Detail.ShowDetail.Response(displayMobile: mobileDetail!)
    self.presenter.presentDetail(response: response)
  }
  
  func doFeedImageURLs(request: Detail.GetImage.Request) {
    
    worker?.feedMobileImageUrls(imageID: mobileDetail?.mobileID ?? 1, completion: { (imageResult) in
      
      let response = Detail.GetImage.Response(imageURLs: imageResult)
      self.presenter.presentImageData(response: response)
    })
  }
  
 
  
  
}
