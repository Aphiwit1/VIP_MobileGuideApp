//
//  DetailPresenter.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 2/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

import UIKit

protocol DetailPresenterInterface {

  func presentDetail(response: Detail.ShowDetail.Response)
  func presentImageData(response: Detail.GetImage.Response)
}

class DetailPresenter: DetailPresenterInterface {
  
  weak var viewController: DetailViewControllerInterface!
  
  // MARK: - Presentation logic
  
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
  
  func presentDetail(response: Detail.ShowDetail.Response) {
 
    let id = response.displayMobile.mobileID
    let name = response.displayMobile.mobilename
    let price = response.displayMobile.mobilePrice
    let rating = response.displayMobile.mobileRating
    let description = response.displayMobile.mobileDescription
    let mobileImage  = response.displayMobile.mobileImage
    
    let displayDatail = Detail.ShowDetail.ViewModel.DisplayMobile(mobileID: id , mobilename: name, mobileRating: rating, mobilePrice: price, mobileDescription: description, mobileImage: mobileImage)
    
    let viewModel = Detail.ShowDetail.ViewModel(displayMobile: displayDatail)
     viewController.displayDetailText(viewModel: viewModel)
    
  }
  
  
}
