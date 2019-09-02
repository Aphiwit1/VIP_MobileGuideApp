//
//  TabAllInteractor.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 2/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

import UIKit

protocol TabAllInteractorInterface {
    func doFeedDataAPI(request: TabAll.FeedDataTable.Request)
}

class TabAllInteractor: TabAllInteractorInterface {

    
  var presenter: TabAllPresenterInterface!
  var worker: TabAllWorker?

  // MARK: - Business logic=
    func doFeedDataAPI(request: TabAll.FeedDataTable.Request) {
        worker?.feedContent(completion: { (result) in
            let response = TabAll.FeedDataTable.Response(mobileListModel: result)
            self.presenter.presentData(response: response)
        })
    }
}
