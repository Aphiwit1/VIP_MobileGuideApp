//
//  DetailMobileListModel.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 28/8/2562 BE.
//  Copyright © 2562 OnceKB. All rights reserved.
//

import Foundation

typealias DetailMobileListModel = [MobileListImage]

class MobileListImage: Codable {
    let url: String
    let id, mobileID: Int

    enum CodingKeys: String, CodingKey {
        case url, id
        case mobileID = "mobile_id"
    }
  
  init(url: String, id: Int, mobileID: Int) {
    self.url = url
    self.id = id
    self.mobileID = mobileID
  }
}

// MARK: Convenience initializers

extension MobileListImage {
//    init?(data: Data) {
//        guard let me = try? JSONDecoder().decode(MobileListImage.self, from: data) else { return nil }
//        self = me
//    }
//
//    init?(_ json: String, using encoding: String.Encoding = .utf8) {
//        guard let data = json.data(using: encoding) else { return nil }
//        self.init(data: data)
//    }
//
//    init?(fromURL url: String) {
//        guard let url = URL(string: url) else { return nil }
//        guard let data = try? Data(contentsOf: url) else { return nil }
//        self.init(data: data)
//    }
//
//    var jsonData: Data? {
//        return try? JSONEncoder().encode(self)
//    }
//
//    var json: String? {
//        guard let data = self.jsonData else { return nil }
//        return String(data: data, encoding: .utf8)
//    }
//}
//
//extension Array where Element == DetailMobileListModel.Element {
//    init?(data: Data) {
//        guard let me = try? JSONDecoder().decode(DetailMobileListModel.self, from: data) else { return nil }
//        self = me
//    }
//
//    init?(_ json: String, using encoding: String.Encoding = .utf8) {
//        guard let data = json.data(using: encoding) else { return nil }
//        self.init(data: data)
//    }
//
//    init?(fromURL url: String) {
//        guard let url = URL(string: url) else { return nil }
//        guard let data = try? Data(contentsOf: url) else { return nil }
//        self.init(data: data)
//    }
//
//    var jsonData: Data? {
//        return try? JSONEncoder().encode(self)
//    }
//
//    var json: String? {
//        guard let data = self.jsonData else { return nil }
//        return String(data: data, encoding: .utf8)
//    }
}
