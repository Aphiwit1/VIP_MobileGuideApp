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
  func displayFavouriteTab(viewModel: TabAll.ShowFavouritesTab.ViewModel)
  
}

class TabAllViewController: UIViewController, TabAllViewControllerInterface, UITableViewDataSource, UITableViewDelegate {

  
  
  @IBOutlet weak var mainTableView: UITableView!
  @IBOutlet weak var FavouriteButton: UIButton!
  
  var interactor: TabAllInteractorInterface!
  var router: TabAllRouter!
  var mobileList : [TabAll.DisplayMobile] = [] {
    didSet {
      mainTableView.reloadData()
    }
  }
//  var mobileFavList: [TabAll.DisplayMobile] = []
  
  
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
    cell?.configureCell(with: item)
    cell?.delegate = self
    return cell!
  }
  
  func displayLoadTableView() {
    mainTableView.reloadData()
  }
  
  func  loadTable(){
    let request = TabAll.FeedDataTable.Request()
    interactor?.doFeedDataAPI(request: request)
  }
  
  func displayResultData(viewModel: TabAll.FeedDataTable.ViewModel) {
    mobileList = viewModel.displayMobileList
  }
  
  @IBAction func sortButton(sender: UIButton){
    print("Check!")
  }
  
  @IBAction func favButton(sender: UIButton){
    let request = TabAll.ShowFavouritesTab.Request()
    interactor.getFavouriteMobiles(request: request)
  }
}

extension TabAllViewController: TabAllCellDelegate {
  func didTapFavorite(with mobileId: Int, isSelected: Bool) {
    print("mobileId: \(mobileId), isSelected: \(isSelected)")
    let request = TabAll.SetFavData.Request(mobileID: mobileId, isFav: isSelected)
    interactor.setFavourite(request: request)
  }
  
  func displayFavouriteTab(viewModel: TabAll.ShowFavouritesTab.ViewModel) {
     mobileList = viewModel.mobileFavList
  }
  
  
}
