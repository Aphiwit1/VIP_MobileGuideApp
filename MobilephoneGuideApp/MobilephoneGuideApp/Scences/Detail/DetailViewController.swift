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
}

class DetailViewController: UIViewController, DetailViewControllerInterface,UICollectionViewDataSource, UICollectionViewDelegate {
  
  

  var interactor: DetailInteractorInterface!
  var router: DetailRouter!
  
  @IBOutlet weak var DetailPrice: UILabel!
  @IBOutlet weak var DetailRating: UILabel!
  @IBOutlet weak var DetailDescription: UILabel!
  @IBOutlet weak var CollectionView: UICollectionView!

  // MARK: - Object lifecycle

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
  }

  // MARK: - Event handling

//  func doSomethingOnLoad() {
//    // NOTE: Ask the Interactor to do some work
//
//    let request = Detail.Something.Request()
//    interactor.doSomething(request: request)
//  }

  // MARK: - Display logic

  func displaySomething(viewModel: Detail.Something.ViewModel) {
    // NOTE: Display the result from the Presenter

    // nameTextField.text = viewModel.name
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
       return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colllectionCell", for: indexPath) as? DetailCollectionViewCell
    
    return cell!
  }
  
  
  func displayImage(viewModel: Detail.GetImage.ViewModel) {
     
  }
  
}
