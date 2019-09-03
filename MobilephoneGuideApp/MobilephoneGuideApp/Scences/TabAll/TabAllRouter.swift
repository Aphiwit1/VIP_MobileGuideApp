//
//  TabAllRouter.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 2/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

import UIKit

protocol TabAllRouterInput {
  func navigateToSomewhere()
  func navigateToDetailPage(mobile: TabAll.FeedDataTable.ViewModel.DisplayMobile)
}

class TabAllRouter: TabAllRouterInput {
 
  weak var viewController: TabAllViewController!

  // MARK: - Navigation

  func navigateToSomewhere() {
    // NOTE: Teach the router how to navigate to another scene. Some examples follow:

    // 1. Trigger a storyboard segue
    // viewController.performSegueWithIdentifier("ShowSomewhereScene", sender: nil)

    // 2. Present another view controller programmatically
    // viewController.presentViewController(someWhereViewController, animated: true, completion: nil)

    // 3. Ask the navigation controller to push another view controller onto the stack
    // viewController.navigationController?.pushViewController(someWhereViewController, animated: true)

    // 4. Present a view controller from a different storyboard
    // let storyboard = UIStoryboard(name: "OtherThanMain", bundle: nil)
    // let someWhereViewController = storyboard.instantiateInitialViewController() as! SomeWhereViewController
    // viewController.navigationController?.pushViewController(someWhereViewController, animated: true)
  }

  // MARK: - Communication

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
  
  
  
  
  func navigateToDetailPage(mobile: TabAll.FeedDataTable.ViewModel.DisplayMobile) {
  
  
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "DetailPage") as? DetailViewController else {
        return assertionFailure("Not found DetailPageStorybaord")
      }
            destinationVC.interactor.mobileDetail = mobile
    
            let request = Detail.GetImage.Request(imageID: mobile.mobileID)
            destinationVC.interactor.doFeedImageURLs(request: request)
        print(mobile)
      viewController.navigationController?.pushViewController(destinationVC, animated: true)
      
    }
  

}
