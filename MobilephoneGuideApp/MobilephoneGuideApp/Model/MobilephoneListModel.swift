//
//  MobilephoneListModel.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 27/8/2562 BE.
//  Copyright © 2562 OnceKB. All rights reserved.
//

import Foundation

typealias MobilephoneListModel = [MobileList]

class MobileList: Codable {
    let rating: Double
    let id: Int
    let thumbImageURL: String
    let price: Double
    let brand, name, description: String
    var favSelected: Bool? = false
  
  init(rating : Double, id : Int, thumbImageURL: String, price: Double, brand: String, name: String, description: String, favSelected: Bool?) {
   
    self.rating = rating
    self.id = id
    self.thumbImageURL = thumbImageURL
    self.price = price
    self.brand = brand
    self.name = name
    self.description = description
    self.favSelected = favSelected
    
  }
}


