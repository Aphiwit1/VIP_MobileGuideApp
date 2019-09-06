//
//  DetailInteractorTests.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 6/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

@testable import MobilephoneGuideApp
import XCTest

class DetailInteractorTests: XCTestCase {

  // MARK: - Subject under test

  var sut: DetailInteractor!
  

  let sutMobileListDetail = TabAll.DisplayMobile(mobileID: 1, mobilename: "", mobileRating: "", mobilePrice: "", mobileDescription: "", mobileImage: "", isFav:  true)
  
  

  // MARK: - Test lifecycle

  final class TabDetailPresenterSpy: DetailPresenterInterface {
    
    
    
    
    var dataIsCalled = false
    
    
    func presentDetail(response: Detail.ShowDetail.Response) {
      dataIsCalled = true
    }
    
    func presentImageData(response: Detail.GetImage.Response) {

    }
    
    
  }
  
  override func setUp() {
    super.setUp()
    setupDetailInteractor()
    
    let presenterSpy = TabDetailPresenterSpy()
    sut.presenter = presenterSpy
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupDetailInteractor() {
    sut = DetailInteractor()
  }

  // MARK: - Test doubles




  
    // MARK: - Tests
  func testInteractorToShowDataInPresenterCaseSuccess() {
    //given
    let presenterSpy = TabDetailPresenterSpy()
     sut.presenter = presenterSpy
    sut.mobileDetail = sutMobileListDetail
    
    //when
    sut.presenter.presentDetail(response: Detail.ShowDetail.Response(displayMobile: sutMobileListDetail))
   
    
    //then
    XCTAssertTrue(presenterSpy.dataIsCalled)
    
  }
}
