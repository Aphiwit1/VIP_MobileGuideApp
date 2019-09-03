//
//  DetailInteractor.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 2/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

import UIKit

protocol DetailInteractorInterface {
  func doSomething(request: Detail.Something.Request)
  func setUpUI(request: Detail.Something.Request)
  var model: Entity? { get }
  var mobileDetail : TabAll.FeedDataTable.ViewModel.DisplayMobile? {get set}
  func doFeedImageURLs(request: Detail.GetImage.Request)
}

class DetailInteractor: DetailInteractorInterface {
 
  
  var mobileDetail: TabAll.FeedDataTable.ViewModel.DisplayMobile?
  
  var presenter: DetailPresenterInterface!
  var worker: DetailWorker?
  var model: Entity?

  // MARK: - Business logic

  func doSomething(request: Detail.Something.Request) {
    worker?.doSomeWork { [weak self] in
      if case let Result.success(data) = $0 {
        // If the result was successful, we keep the data so that we can deliver it to another view controller through the router.
        self?.model = data
      }
      // NOTE: Pass the result to the Presenter. This is done by creating a response model with the result from the worker. The response could contain a type like UserResult enum (as declared in the SCB Easy project) with the result as an associated value.
      let response = Detail.Something.Response()
      self?.presenter.presentSomething(response: response)
    }
  }
  
  func setUpUI(request: Detail.Something.Request) {
//      let response = Detail.Something.Response()
      
  }
  
  func doFeedImageURLs(request: Detail.GetImage.Request) {
    worker?.feedMobileImageUrls(imageID: request.imageID, completion: { (imageResult) in
         let response = Detail.GetImage.Response(imageURLs: imageResult)
//         
    })
  }
  
  
  
}
