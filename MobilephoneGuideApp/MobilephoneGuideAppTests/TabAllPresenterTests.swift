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
    var mobileListFormat: TabAll.FeedDataTable.ViewModel?
    var mobileListFormatForFav: TabAll.ShowFavouritesTab.ViewModel?
    var mobileListFormateForTabAll: TabAll.ShowAllTab.ViewModel?
    
    
    func displayResultData(viewModel: TabAll.FeedDataTable.ViewModel) {
      //todo
      mobileListFormat = viewModel
      displayData = true
      
    }
    
    func displayFavouriteTab(viewModel: TabAll.ShowFavouritesTab.ViewModel) {
      mobileListFormatForFav = viewModel
      displayData = true
    }
    
    func displayAllTab(viewModel: TabAll.ShowAllTab.ViewModel) {
      displayData = true
      mobileListFormateForTabAll = viewModel
      
    }
    
    var presentDataCalled = false
    
  }
  
  // MARK: - Test doubles
  
  // MARK: - Tests
  
  
  func testPresentDataShouldAskViewControllerToDisplayCaseSuccess() {
    // given
    let expectString = "Rating: 5.0"
    let exptectPrice = "Price: $100.0"
    let tabAllViewControllerSpy = TabAllViewControllerSpy()
    sut.viewController = tabAllViewControllerSpy
    let mobileListMock = sutMobileList
  
    // When
    sut.presentData(response: TabAll.FeedDataTable.Response(mobileListModel: .success(mobileListMock)))
    
    // Then
    XCTAssertTrue(tabAllViewControllerSpy.displayData)
    guard let mobileListFormat = tabAllViewControllerSpy.mobileListFormat else {
      return
    }
    switch mobileListFormat.displayMobileList {
    case .success(let displayMobiles):
      XCTAssertEqual(displayMobiles.first?.mobileRating, expectString)
      XCTAssertEqual(displayMobiles[0].mobilePrice, exptectPrice)
    case .failure(let error):
      print(error.localizedDescription)
      break
    }
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
  
  
  func  testPresentFavouriteTabRatingAndPriceFormatShouldAskViewControllerToDisplayCaseSuccess()  {
    //given
    
    let expectRating = "Rating: 5.0"
    let expectPrice = "Price: $100.0"
    let tabAllViewControllerSpy = TabAllViewControllerSpy()
    sut.viewController = tabAllViewControllerSpy
    let mobileListMock = sutMobileList
    //when
    sut.presentFavouriteTab(response: TabAll.ShowFavouritesTab.Response(mobileListModel: mobileListMock))
    
    //then
    XCTAssert(tabAllViewControllerSpy.displayData)
    guard let mobileListFormat = tabAllViewControllerSpy.mobileListFormatForFav else {
      return
      
    }
    
    XCTAssert(tabAllViewControllerSpy.displayData)
  XCTAssertEqual(mobileListFormat.mobileFavList.first?.mobilePrice,expectPrice)
    XCTAssertEqual(mobileListFormat.mobileFavList[0].mobileRating, expectRating)
    
  }
  
  
  func testPresentFavouriteTabShouldAskViewControllerToDisplayCaseSuccess() {
    //given
    let tabAllViewControllerSpy = TabAllViewControllerSpy()
    sut.viewController = tabAllViewControllerSpy
    let mobileListMock = sutMobileList
    
    //when
    sut.presentFavouriteTab(response: TabAll.ShowFavouritesTab.Response(mobileListModel: mobileListMock))
    
    //then
    XCTAssert(tabAllViewControllerSpy.displayData)
  }
  
  
  func testPresenterAllTabShouldAskViewControllerToDisplayCaseSuccess() {
    //given
    
    let expectRating = "Rating: 5.0"
    let expectPrice = "Price: $100.0"
    
    let tabAllViewControllerSpy = TabAllViewControllerSpy()
    sut.viewController = tabAllViewControllerSpy
    let mobileListMock = sutMobileList
    
    //when
    sut.presentAllTab(response: TabAll.ShowAllTab.Response(mobileListModel: mobileListMock))
    
    //then
    guard let mobileFormatForTabAll = tabAllViewControllerSpy.mobileListFormateForTabAll else { return }
    XCTAssert(tabAllViewControllerSpy.displayData)
    XCTAssertEqual(mobileFormatForTabAll.mobileFavList.first?.mobilePrice, expectPrice)
    XCTAssertEqual(mobileFormatForTabAll.mobileFavList.first?.mobileRating, expectRating)
    
  }
  
  
  
  
}

