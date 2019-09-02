//
//  Extension.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 27/8/2562 BE.
//  Copyright © 2562 OnceKB. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

extension UIImageView {
    func loadImage(url : String) {
        self.af_setImage(withURL: URL(string: url)!)
    }
}


