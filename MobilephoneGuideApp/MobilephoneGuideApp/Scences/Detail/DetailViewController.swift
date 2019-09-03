//
//  DetailViewController.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 2/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

import UIKit

protocol DetailViewControllerInterface: class {
  func displaySomething(viewModel: Detail.Something.ViewModel)
  func displayImage(viewModel: Detail.GetImage.ViewModel)
  func displayDetailText(viewModel: Detail.ShowDetail.ViewModel)
  
//  var mobileDetail : TabAll.FeedDataTable.ViewModel.DisplayMobile? {get set}

}

class DetailViewController: UIViewController, DetailViewControllerInterface,UICollectionViewDataSource, UICollectionViewDelegate {
  
  
  
//  var mobileDetail: TabAll.FeedDataTable.ViewModel.DisplayMobile?
  
 
  var interactor: DetailInteractorInterface!
  var router: DetailRouter!
  
  @IBOutlet weak var detailPrice: UILabel!
  @IBOutlet weak var detailRating: UILabel!
  @IBOutlet weak var detailDescription: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!

  // MARK: - Object lifecycle
  
  var images : [Detail.GetImage.ViewModel.MobileImage] = []

  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }

  // MARK: - Configuration

  private func configure(viewController: DetailViewController) {
    let router = DetailRouter()
    router.viewController = viewController

    let presenter = DetailPresenter()
    presenter.viewController = viewController

    let interactor = DetailInteractor()
    interactor.presenter = presenter
    interactor.worker = DetailWorker(store: DetailStore())

    viewController.interactor = interactor
    viewController.router = router
  }

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
//    doSomethingOnLoad()
    let request = Detail.ShowDetail.Request()
    interactor.setUpUI(request: request)
    self.collectionView.dataSource = self
    
    let requestImage = Detail.GetImage.Request()
    interactor.doFeedImageURLs(request: requestImage)
  }
  
  func doLoadImage() {
//    let request = Detail.GetImage.Request(imageID: mobileDetail?.mobileID ?? 1)
//    interactor?.doFeedImageURLs(request: request)
  }


  func displaySomething(viewModel: Detail.Something.ViewModel) {
    // NOTE: Display the result from the Presenter
      
    
  }

  // MARK: - Router

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }

  @IBAction func unwindToDetailViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colllectionCell", for: indexPath) as? DetailCollectionViewCell
    let a = images[indexPath.row]
    cell?.imageCollectionView.loadImage(url: a.url )
    print("---->", cell?.imageCollectionView.loadImage(url: a.url ))
    return cell!
  }
  
  
  func displayImage(viewModel: Detail.GetImage.ViewModel) {
    images = viewModel.mobileImages
    print(images)
     self.collectionView.reloadData()
  }
  
  
  func displayDetailText(viewModel: Detail.ShowDetail.ViewModel) {
       detailPrice.text = viewModel.displayMobile.mobilePrice
       detailRating.text = viewModel.displayMobile.mobileRating
       detailDescription.text = viewModel.displayMobile.mobileDescription
  }
  
}
