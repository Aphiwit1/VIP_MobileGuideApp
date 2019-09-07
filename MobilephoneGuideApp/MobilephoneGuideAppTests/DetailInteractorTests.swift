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
  let sutMobileListDetail = TabAll.DisplayMobile(mobileID: 1, mobilename: "", mobileRating: "", mobilePrice: "", mobileDescription: "", mobileImage: "www.google.com/image", isFav:  true)
  
  // MARK: - Test lifecycle
  
  final class TabDetailWorkerSpy: DetailWorker{
    
    var isShouldFail = false
    
    override func feedMobileImageUrls(imageID: Int, completion: @escaping ([MobileListImage]) -> Void) {
      completion(
        [MobileListImage(url: "ddd", id: 1, mobileID: 1)]
      )
    }
  }
  
  final class TabDetailPresenterSpy: DetailPresenterInterface {
    var dataIsCalled = false
    func presentDetail(response: Detail.ShowDetail.Response) {
      dataIsCalled = true
    }
    func presentImageData(response: Detail.GetImage.Response) {
      dataIsCalled = true
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
  func testInteractorToShowDetailInPresenterCaseSuccess() {
    //given
    let presenterSpy = TabDetailPresenterSpy()
    sut.presenter = presenterSpy
    sut.mobileDetail = sutMobileListDetail
    
    //when
    sut.setUpUI(request: Detail.ShowDetail.Request())
    
    //then
    XCTAssertTrue(presenterSpy.dataIsCalled)
  }
  
  func testInteractorToShowDetailImageInPresenterCaseSuccess() {
    //given
    let presenterSpy = TabDetailPresenterSpy()
    sut.worker = TabDetailWorkerSpy(store: DetailStore())
    sut.presenter = presenterSpy
    sut.mobileDetail = sutMobileListDetail
    //when
    sut.doFeedImageURLs(request: Detail.GetImage.Request())
    //then
    XCTAssertTrue(presenterSpy.dataIsCalled)
  }
  
}
