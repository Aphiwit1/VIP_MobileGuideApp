//
//  TabAllViewController.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 2/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

import UIKit

protocol TabAllViewControllerInterface: class {
        func displayResultData(viewModel: TabAll.FeedDataTable.ViewModel)
}

class TabAllViewController: UIViewController, TabAllViewControllerInterface, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var interactor: TabAllInteractorInterface!
    var router: TabAllRouter!
    var mobileList : [TabAll.FeedDataTable.ViewModel.DisplayMobile] = []
    
    // MARK: - Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure(viewController: self)
    }
    
    // MARK: - Configuration
    
    private func configure(viewController: TabAllViewController) {
        let router = TabAllRouter()
        router.viewController = viewController
        
        let presenter = TabAllPresenter()
        presenter.viewController = viewController
        
        let interactor = TabAllInteractor()
        interactor.presenter = presenter
        interactor.worker = TabAllWorker(store: TabAllStore())
        
        viewController.interactor = interactor
        viewController.router = router
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTable()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mobileList.count
    }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       router.navigateToDetailPage(mobile: mobileList[indexPath.row])
  }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tabAllCell") as? TabAllCell
        let item = mobileList[indexPath.row]
        cell?.mobilename.text = item.mobilename
        cell?.mobileDescription.text = item.mobileDescription
        cell?.mobilePrice.text = item.mobilePrice
        cell?.mobileRating.text = item.mobileRating
        cell?.mobileImage.loadImage(url: item.mobileImage)
        return cell!
    }
    
    // MARK: - Event handling

    
    // MARK: - Display logic
    
    
    
    func displayLoadTableView() {
        mainTableView.reloadData()
        
    }
    
    func  loadTable(){
        let request = TabAll.FeedDataTable.Request()
        interactor?.doFeedDataAPI(request: request)
    }
    
    func displayResultData(viewModel: TabAll.FeedDataTable.ViewModel) {
        mobileList = viewModel.displayMobileList
        mainTableView.reloadData()
    }
    // MARK: - Router
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue: segue)
    }
    
    @IBAction func unwindToTabAllViewController(from segue: UIStoryboardSegue) {
        print("unwind...")
        router.passDataToNextScene(segue: segue)
    }
    
}
