//
//  TabAllPresenterTests.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 4/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

@testable import MobilephoneGuideApp
import XCTest

class TabAllPresenterTests: XCTestCase {

  // MARK: - Subject under test

  var sut: TabAllPresenter!
  
  
  var sutMobileList = [
    MobileList(
      rating: 5.0,
      id: 1,
      thumbImageURL: "",
      price: 100.0,
      brand: "",
      name: "",
      description: "",
      favSelected: false
    ),
    MobileList(
      rating: 4.0,
      id: 2,
      thumbImageURL: "",
      price: 200.0,
      brand: "",
      name: "",
      description: "",
      favSelected: false
    ),
    MobileList(
      rating: 3.0,
      id: 3,
      thumbImageURL: "",
      price: 300.0,
      brand: "",
      name: "",
      description: "",
      favSelected: nil
    )
  ]

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupTabAllPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupTabAllPresenter() {
    sut = TabAllPresenter()
  }
  
  class TabAllViewControllerSpy: TabAllViewControllerInterface {
    
    var displayData = false
    func displayResultData(viewModel: TabAll.FeedDataTable.ViewModel) {
      displayData = true
    }
    
    func displayFavouriteTab(viewModel: TabAll.ShowFavouritesTab.ViewModel) {
      displayData = true
    }
    
    func displayAllTab(viewModel: TabAll.ShowAllTab.ViewModel) {
      displayData = true
    }
    
    var presentDataCalled = false
    
    
    
  }

  // MARK: - Test doubles

  // MARK: - Tests

  func testSomething() {
    // Given

    // When

    // Then
  }
  
  func testPresentDataShouldAskViewControllerToDisplayCaseSuccess() {
    // given
    let tabAllViewControllerSpy = TabAllViewControllerSpy()
    sut.viewController = tabAllViewControllerSpy
    let mobileListMock = sutMobileList

    // When
    sut.presentData(response: TabAll.FeedDataTable.Response(mobileListModel: .success(mobileListMock)))
    
    // Then
    XCTAssert(tabAllViewControllerSpy.displayData)
  }
  
  
  
  func testPresentDataShouldAskViewControllerToDisplayCaseFail() {
    //given
    let tabAllViewControllerSpy = TabAllViewControllerSpy()
    sut.viewController = tabAllViewControllerSpy

    
    //when
    sut.presentData(response: TabAll.FeedDataTable.Response(mobileListModel: .failure(apiError.runTimeout)
    ))
    //then
    XCTAssert(tabAllViewControllerSpy.displayData)
  }
  
  
  func  testPresentFavouriteTabShouldAskViewControllerToDisplayCaseSuccess()  {
    //given
    let tabAllViewControllerSpy = TabAllViewControllerSpy()
    sut.viewController = tabAllViewControllerSpy
    let mobileListMock = sutMobileList
    //when
    sut.presentFavouriteTab(response: TabAll.ShowFavouritesTab.Response(mobileListModel: mobileListMock))
    
    //then
    XCTAssert(tabAllViewControllerSpy.displayData)
  }
  
  
  func estPresentFavouriteTabShouldAskViewControllerToDisplayCaseSuccess() {
    //given
    let tabAllViewControllerSpy = TabAllViewControllerSpy()
    sut.viewController = tabAllViewControllerSpy
    let mobileListMock = sutMobileList
    
    //when
    sut.presentFavouriteTab(response: TabAll.ShowFavouritesTab.Response(mobileListModel: mobileListMock))
    
    
    //then
    XCTAssert(tabAllViewControllerSpy.displayData)
    
  }
  
  
  func testPresentAllTabShouldAskViewControllerToDisplayCaseSuccess() {
    //given
    let tabAllViewControllerSpy = TabAllViewControllerSpy()
    sut.viewController = tabAllViewControllerSpy
    let mobileListMock = sutMobileList
    
    //when
    sut.presentAllTab(response: TabAll.ShowAllTab.Response(mobileListModel: mobileListMock))
    
    //then
    XCTAssert(tabAllViewControllerSpy.displayData)
  }
  
  
  
  
}

