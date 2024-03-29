//
//  DetailPresenterTests.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 6/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

@testable import MobilephoneGuideApp
import XCTest

class DetailPresenterTests: XCTestCase {

  // MARK: - Subject under test
  var sut: DetailPresenter!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupDetailPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupDetailPresenter() {
    sut = DetailPresenter()
  }

  // MARK: - Test doubles
  
  let sutMobileListDetail = TabAll.DisplayMobile(mobileID: 1, mobilename: "", mobileRating: "", mobilePrice: "", mobileDescription: "", mobileImage: "www.google.com/image", isFav:  true)
  
  let sutImageMobileDetail = MobileListImage(url: "www.scb.com/image", id: 1, mobileID: 1)
  
  class TabDetailViewControllerSpy: DetailViewControllerInterface {
    var viewControllerIsCalled: Bool = false
    func displayImage(viewModel: Detail.GetImage.ViewModel) {
      viewControllerIsCalled = true
    }
    func displayDetailText(viewModel: Detail.ShowDetail.ViewModel) {
      viewControllerIsCalled = true
    }
  }
  
  // MARK: - Tests

  func testDetailPresenterShouldAskDetailViewControllerCaseSuccess() {
    // Given
    let tabDetailViewControllerSpy = TabDetailViewControllerSpy()
    sut.viewController = tabDetailViewControllerSpy
    let mobileDetail = sutMobileListDetail
    // When
    sut.presentDetail(response: Detail.ShowDetail.Response(displayMobile: mobileDetail))
    // Then
    XCTAssertTrue(tabDetailViewControllerSpy.viewControllerIsCalled)
  }
  
  func testDetailImagePresenterShouldAskDetailViewControllerCaseSuccess() {
    //Given
    let tabDetailViewControllerSpy = TabDetailViewControllerSpy()
    sut.viewController = tabDetailViewControllerSpy
    let mobileImage = sutImageMobileDetail
    //Then
    sut.presentImageData(response: Detail.GetImage.Response(imageURLs: [mobileImage]))
    //When
    XCTAssertTrue(tabDetailViewControllerSpy.viewControllerIsCalled)
  }
}
