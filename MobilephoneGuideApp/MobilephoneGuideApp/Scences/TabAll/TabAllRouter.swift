//
//  TabAllRouter.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 2/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

import UIKit

protocol TabAllRouterInput {

  func navigateToDetailPage(mobile: TabAll.DisplayMobile)
}

class TabAllRouter: TabAllRouterInput {
 
  weak var viewController: TabAllViewController!
  func passDataToNextScene(segue: UIStoryboardSegue) {
    // NOTE: Teach the router which scenes it can communicate with

    if segue.identifier == "ShowSomewhereScene" {
      passDataToSomewhereScene(segue: segue)
    }
  }

  func passDataToSomewhereScene(segue: UIStoryboardSegue) {
    // NOTE: Teach the router how to pass data to the next scene

    // let someWhereViewController = segue.destinationViewController as! SomeWhereViewController
    // someWhereViewController.interactor.model = viewController.interactor.model
  }
  
  
  
  
  func navigateToDetailPage(mobile: TabAll.DisplayMobile) {
  
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "DetailPage") as? DetailViewController else {
        return assertionFailure("Not found DetailPageStorybaord")
      }
            destinationVC.interactor.mobileDetail = mobile
      viewController.navigationController?.pushViewController(destinationVC, animated: true)
      
    }
  

}
