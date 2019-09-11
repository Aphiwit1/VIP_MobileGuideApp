//
//  TabAllCell.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 2/9/2562 BE.
//  Copyright © 2562 OnceKB. All rights reserved.
//

import UIKit

protocol TabAllCellDelegate {
  func didTapFavorite(with mobileId: Int, isSelected: Bool)
}

class TabAllCell: UITableViewCell {
  
  typealias DisplayMobile = TabAll.DisplayMobile
  var displayMobile: DisplayMobile?
  @IBOutlet weak var mobilename: UILabel!
  @IBOutlet weak var mobileDescription: UILabel!
  @IBOutlet weak var mobilePrice: UILabel!
  @IBOutlet weak var mobileRating: UILabel!
  @IBOutlet weak var mobileFavBtn: UIButton!
  
  @IBOutlet weak var mobileImage: UIImageView!
  var delegate: TabAllCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configureCell(with displayMobile: DisplayMobile) {
    self.displayMobile = displayMobile
    mobilename.text = displayMobile.mobilename
    mobileDescription.text = displayMobile.mobileDescription
    mobilePrice.text = displayMobile.mobilePrice
    mobileRating.text = displayMobile.mobileRating
    mobileImage.loadImage(url: displayMobile.mobileImage)
    mobileFavBtn.isSelected = displayMobile.isFav ?? false
  }
  
  @IBAction func checkFavouriteButton(sender: UIButton) {
    guard let displayMobile = displayMobile else { return }
    mobileFavBtn.isSelected = !sender.isSelected
    delegate?.didTapFavorite(
      with: displayMobile.mobileID,
      isSelected: mobileFavBtn.isSelected
    )
  }
  
}
