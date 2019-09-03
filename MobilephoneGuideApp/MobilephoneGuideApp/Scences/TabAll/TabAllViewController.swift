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
  func displayAllTab(viewModel: TabAll.ShowAllTab.ViewModel)
}

class TabAllViewController: UIViewController, TabAllViewControllerInterface, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var mainTableView: UITableView!
  @IBOutlet weak var favouriteTabButton: UIButton!
  @IBOutlet weak var allTabButton: UIButton!
  
  var interactor: TabAllInteractorInterface!
  var router: TabAllRouter!
  var mobileList : [TabAll.DisplayMobile] = [] {
    didSet {
      mainTableView.reloadData()
    }
  }
  
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
    favouriteTabButton.setTitleColor(.gray, for: .normal)
    allTabButton.setTitleColor(.blue, for: .normal)
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
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? TabAllCell else {
      return
    }
    if editingStyle == .delete {
      guard let id = cell.displayMobile?.mobileID else { return  }
      didTapFavorite(with: id, isSelected: false)
      
    }
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
  
  @IBAction func sortTable(sender: UIBarButtonItem){
    var sortType : Int = 0
    if self.allTabButton.isSelected {
      sortType = allTabButton.tag
    } else {
      sortType = favouriteTabButton.tag
    }
    
    let alert = UIAlertController(title: "Sorting", message: "", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Price low to hight", style: .default, handler: { _ in
      let request = TabAll.SortTable.Request(sortType: .PriceHightToLow,tagSoprt: sortType)
      self.interactor.getSorting(resquest: request)
    }))
    
    alert.addAction(UIAlertAction(title: "Price low to hight", style: .default, handler: { _ in
      let request = TabAll.SortTable.Request(sortType: .PriceLowToHight, tagSoprt: sortType)
      self.interactor.getSorting(resquest: request)
    }))
    
    alert.addAction(UIAlertAction(title: "Price low to hight", style: .default, handler: { _ in
      let request = TabAll.SortTable.Request(sortType: .RatingHightToLow, tagSoprt: sortType)
      self.interactor.getSorting(resquest: request)
    }))
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func favButton(sender: UIButton){
    let request = TabAll.ShowFavouritesTab.Request()
    interactor.getFavouriteMobiles(request: request)
    allTabButton.setTitleColor(.gray, for: .normal)
    favouriteTabButton.setTitleColor(.blue, for: .normal)
  }
  
  @IBAction func allButton(sender: UIButton){
    let request = TabAll.ShowAllTab.Request()
    interactor.getAllMobiles(resquest: request)
    favouriteTabButton.setTitleColor(.gray, for: .normal)
    allTabButton.setTitleColor(.blue, for: .normal)
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
  
  func displayAllTab(viewModel: TabAll.ShowAllTab.ViewModel) {
    mobileList = viewModel.mobileFavList
  }
  
  
}

