//
//  APIManager.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 29/8/2562 BE.
//  Copyright © 2562 OnceKB. All rights reserved.
//

import Foundation
import Alamofire

class FeedData{

    func feedContent(completion:  @escaping(_ result: [MobileList]) -> Void) {
        let baseUrl = "https://scb-test-mobile.herokuapp.com/api/mobiles"
        AF.request(baseUrl).response { (response) in
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode([MobileList].self, from: response.data!)
                completion(result)
            }catch {
                print("---error --->", error.localizedDescription)
            }
        }
    }
    
    
    // start to feed image content
    func getDetail_mobileList(imageID: Int, completion:  @escaping(_ result: [PurpleDetailMobileListModel]) -> Void) {
        let baseUrl = "https://scb-test-mobile.herokuapp.com/api/mobiles/\(imageID)/images/"
        AF.request(URL(string: baseUrl)!, method: .get ).responseJSON { response in
            print(response)
            switch response.result {
            case let .success(value):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([PurpleDetailMobileListModel].self, from: response.data!)
                    completion(result)
                } catch let error{
                    print("error case success")
                    print(error)
                }
                break
            case let .failure(error):
                print("error case failure")
                print(error)
                break
            }
        }
    }
    
    // end to feed image content
    
    
    
    
}

