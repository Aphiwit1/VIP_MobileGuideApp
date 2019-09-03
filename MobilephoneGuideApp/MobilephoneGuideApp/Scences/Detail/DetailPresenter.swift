//
//  DetailPresenter.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 2/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

import UIKit

protocol DetailPresenterInterface {
  func presentSomething(response: Detail.Something.Response)
  func presentImageData(response: Detail.GetImage.Response)
}

class DetailPresenter: DetailPresenterInterface {
  
  weak var viewController: DetailViewControllerInterface!

  // MARK: - Presentation logic

  func presentSomething(response: Detail.Something.Response) {
    // NOTE: Format the response from the Interactor and pass the result back to the View Controller. The resulting view model should be using only primitive types. Eg: the view should not need to involve converting date object into a formatted string. The formatting is done here.

    let viewModel = Detail.Something.ViewModel()
    viewController.displaySomething(viewModel: viewModel)
  }
  
  
  func presentImageData(response: Detail.GetImage.Response) {
    
    var images : [Detail.GetImage.ViewModel.MobileImage] = []
    for image in response.imageURLs {
      let url = image.url
      
      let newImage = Detail.GetImage.ViewModel.MobileImage(url: url)
      images.append(newImage)
      print(image)
    }
    
    let viewModel = Detail.GetImage.ViewModel(mobileImages: images)
     viewController.displayImage(viewModel: viewModel)
  }
  
}
