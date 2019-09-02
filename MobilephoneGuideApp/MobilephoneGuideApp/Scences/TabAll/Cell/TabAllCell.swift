//
//  TabAllCell.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 2/9/2562 BE.
//  Copyright © 2562 OnceKB. All rights reserved.
//

import UIKit

class TabAllCell: UITableViewCell {
    
    @IBOutlet weak var mobilename: UILabel!
    @IBOutlet weak var mobileDescription: UILabel!
    @IBOutlet weak var mobilePrice: UILabel!
    @IBOutlet weak var mobileRating: UILabel!
    @IBOutlet weak var mobileFavBtn: UIButton!
    
    @IBOutlet weak var mobileImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
