//
//  CardDetailViewController.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 28/8/2562 BE.
//  Copyright © 2562 OnceKB. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class CardDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var mDetailPrice: UILabel!
    @IBOutlet weak var mDetailRating: UILabel!
    @IBOutlet weak var mDetailDescription: UILabel!
    @IBOutlet weak var mCollectionView: UICollectionView!
    
    
    var mDataArray: [PurpleDetailMobileListModel] = []
    var vc2imageURLS : [String] = []
    var feedInfo = FeedData() 
    
    var vc2PriceLabel = ""
    var vc2RatingLabel = ""
    var vc2DecriptionLabel = ""
    var vc2ID: Int!
    
    var imageArray: [String] = []
    var number = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
        mDetailPrice.text = vc2PriceLabel
        mDetailRating.text = vc2RatingLabel
        mDetailDescription.text = vc2DecriptionLabel
        feedImageContent()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionView", for: indexPath) as? CardDetailCollectionViewCell
        cell?.mMobileCollectionView.loadImage(url: imageArray[indexPath.row])
        return cell!
    }
    
    func feedImageContent() {
        feedInfo.getDetail_mobileList(imageID: self.vc2ID) { (result) in
            for eachImage in result {
                self.imageArray.append(eachImage.url)
            }
            self.mCollectionView.reloadData()
        }
    }
    
}
