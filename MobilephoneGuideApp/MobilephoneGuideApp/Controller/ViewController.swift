//
//  ViewController.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 27/8/2562 BE.
//  Copyright © 2562 OnceKB. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mSorting: UIBarButtonItem!
    @IBOutlet weak var mAllBtn: UIButton!
    @IBOutlet weak var mFavoriteBtn: UIButton!

    let feedInfo = FeedData()
    var id : Int?
    var mobile_image:[String] = []
    var mobile_image_id:[Any] = []
    var mDataArray: [MobileList] = [] {
        didSet {
            mTableView.reloadData()
        }
    }
    
    var mDataArrayForAllSection : [MobileList] = []
    @IBOutlet weak var  mTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tabAllCell") as? TabAllTableViewCell
        let item = mDataArray[indexPath.row]
        cell?.mData = item
        cell?.mMobileName.text = item.name
        cell?.mMobilePrice.text = "Price: $\(String(item.price))"
        cell?.mMobileDescription.text = item.description
        cell?.mMobileRating.text = "Rating: \(String(item.rating))"
        cell?.mImageView.loadImage(url: item.thumbImageURL)
        
        if let favSelected = cell?.mData.favSelected {
            cell?.mFavBtn.isSelected = favSelected
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc2 = storyboard?.instantiateViewController(withIdentifier: "cardDetailStorybaord") as? CardDetailViewController
        let item = mDataArray[indexPath.row]
        vc2?.title = item.name
        vc2?.vc2DecriptionLabel = item.description
        vc2?.vc2PriceLabel = "Rating : \(String(item.price))"
        vc2?.vc2RatingLabel = "Price: \(String(item.rating))"
        vc2?.vc2ID = item.id
        vc2?.vc2imageURLS = mobile_image
        self.navigationController?.pushViewController(vc2!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? TabAllTableViewCell
        if editingStyle == .delete {
            if cell?.mFavBtn.isSelected == true {
                cell?.mData.favSelected = false
                cell?.mFavBtn.isSelected = false
                filterFavoriteSection()
                print("Hello")
            }
        }
    }
    func feedData() {
        feedInfo.feedContent { (result) in
            self.mDataArray = result
        }
    }
    

    @IBAction func clickToSort(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Sorting", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Price low to hight", style: .default, handler: { _ in
            self.mDataArray.sort { (first: MobileList, second: MobileList) -> Bool in
                first.price < second.price
            }
        }))
        
        //price high to low
        alert.addAction(UIAlertAction(title: "Price hight to low", style: .default, handler: { _ in
            self.mDataArray.sort { (first: MobileList, second: MobileList) -> Bool in
                first.price > second.price
            }
        }))
        
        //rating low to hight
        alert.addAction(UIAlertAction(title: "Rating low to hight", style: .default, handler: { _ in
            self.mDataArray.sort { (first: MobileList, second: MobileList) -> Bool in
                first.rating < second.rating
            }
        }))
        
        //rating
        alert.addAction(UIAlertAction(title: "Rating hight to low", style: .default, handler: { _ in
            self.mDataArray.sort { (first: MobileList, second: MobileList) -> Bool in
                first.rating > second.rating
            }

        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnAll(sender: UIButton) {
        mDataArray = mDataArrayForAllSection
    }
    
    @IBAction func btnFavortie(sender: UIButton) {
        filterFavoriteSection()
    }
    
    func filterFavoriteSection() {
        let favourites = mDataArrayForAllSection.filter { $0.favSelected ?? false }
        let names = favourites.map { $0.description }
        mDataArray = favourites
    }
    
}

