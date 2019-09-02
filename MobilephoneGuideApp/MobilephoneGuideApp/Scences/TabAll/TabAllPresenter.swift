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
  
}

class TabAllPresenter: TabAllPresenterInterface {
    weak var viewController: TabAllViewControllerInterface!

    
    func presentData(response: TabAll.FeedDataTable.Response) {
//        var displayMobileList : [TabAll.FeedDataTable.ViewModel.DisplayMobile] = []
//        for mobile in response.mobileListModel {
//            let price = "Price: $\(String(mobile.price))"
//            let rating = "Rating: $\(String(mobile.rating))"
//            let name = mobile.name
//            let description = mobile.description
//            let displayMobile = TabAll.FeedDataTable.ViewModel.DisplayMobile(
//                mobilename: name,
//                mobileRating: rating,
//                mobilePrice: price,
//                mobileDescription: description
//            )
//            displayMobileList.append(displayMobile)
//        }
//        let mobileList = TabAll.FeedDataTable.ViewModel(mobileListModel: response.mobileListModel)
        
        let displayMobileList = response.mobileListModel.map {
            TabAll.FeedDataTable.ViewModel.DisplayMobile(
                mobilename: $0.name,
                mobileRating: "Rating: $\(String($0.rating))",
                mobilePrice: "Price: $\(String($0.price))",
                mobileDescription: $0.description,
                mobileImage: $0.thumbImageURL
            )
        }
        let mobileViewModel = TabAll.FeedDataTable.ViewModel(
            displayMobileList: displayMobileList
        )
        viewController.displayResultData(viewModel: mobileViewModel)
        
    }
}
