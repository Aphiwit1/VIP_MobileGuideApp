//
//  TabAllInteractorTests.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 4/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

@testable import MobilephoneGuideApp
import XCTest

enum TestError : Error {
  case fail
}

class TabAllInteractorTests: XCTestCase {
  
  // MARK: - Subject under test
  
  var sut: TabAllInteractor!
  
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
    setupTabAllInteractor()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  func setupTabAllInteractor() {
    sut = TabAllInteractor()
  }
  
  // MARK: - Test doubles
  
  // MARK: - Tests
  
  final class TabAllWorkerSpy: TabAllWorker{
    // MARK: Method call expectations
    
    var shouldFail = false
    
    //   MARK: Spied methods
    
    override func feedContent(completion: @escaping (Swift.Result<[MobileList], Error>) -> Void) {
      if shouldFail {
        completion(.failure(TestError.fail))
      } else {
        completion(
          .success(
            [
              MobileList(
                rating: 0.0,
                id: 1,
                thumbImageURL: "",
                price: 0.0,
                brand: "",
                name: "",
                description: "",
                favSelected: true
              ),
              MobileList(
                rating: 0.0,
                id: 2,
                thumbImageURL: "",
                price: 0.0,
                brand: "",
                name: "",
                description: "",
                favSelected: nil
              )
            ]
          )
        )
      }
    }
  }
  
  final class TabAllPresenterSpy: TabAllPresenterInterface {
    var presentDataCalled : Bool = false
    
    func presentData(response: TabAll.FeedDataTable.Response) {
      presentDataCalled = true
    }
    
    func presentDataFavourite(response: TabAll.SetFavData.Response) {
    }
    
    func presentFavouriteTab(response: TabAll.ShowFavouritesTab.Response) {
      presentDataCalled = true
    }
    
    func presentAllTab(response: TabAll.ShowAllTab.Response) {
      presentDataCalled = true
    }
    
    func getSorting(resquest: TabAll.SortTable.Request){
      presentDataCalled = true
    }

  
  }
  
  
  func testFetchMobileListShouldAskTabAllWorkerToFetchApiPresenterToShowResultCaseFail()
  {
    // Given
    let tabAllWorkerSpy = TabAllWorkerSpy(store: TabAllStore())
    sut.worker = tabAllWorkerSpy
    tabAllWorkerSpy.shouldFail = true
    let presenterSpy = TabAllPresenterSpy()
    sut.presenter = presenterSpy
    
    // When
    sut.fetchMobileList(request: TabAll.FeedDataTable.Request())
    
    // Then
    XCTAssert(presenterSpy.presentDataCalled)
  }
  
  func testFetchMobileListShouldAskTabAllWorkerToFetchApiPresenterToShowResultCaseSuccess()
  {
    // Given
    let tabAllWorkerSpy = TabAllWorkerSpy(store: (TabAllStore()))
    sut.worker = tabAllWorkerSpy
    tabAllWorkerSpy.shouldFail = false
    let presenterSpy = TabAllPresenterSpy()
    sut.presenter = presenterSpy
    
    // When
    sut.fetchMobileList(request: TabAll.FeedDataTable.Request())
    
    // Then
    XCTAssert(presenterSpy.presentDataCalled)
    XCTAssertEqual(sut.dataArray.count, 2)
    
  }
  
  
  func testGetAllMobileTabAllToShowResultCaseSuccess()
  {
    //given
    let presenterSpy = TabAllPresenterSpy()
    sut.presenter = presenterSpy
    
    //when
    sut.getAllMobiles(resquest: TabAll.ShowAllTab.Request())
    
    //then
    XCTAssertTrue(presenterSpy.presentDataCalled)
  }
  
  func testGetFavouriteMobileTabAllToShowResultCaseSuccess() {
    //given
    let presenterSpy = TabAllPresenterSpy()
    sut.presenter = presenterSpy
    sut.dataArray = [
      MobileList(
        rating: 0.0,
        id: 1,
        thumbImageURL: "",
        price: 0.0,
        brand: "",
        name: "",
        description: "",
        favSelected: true
      ),
      MobileList(
        rating: 0.0,
        id: 2,
        thumbImageURL: "",
        price: 0.0,
        brand: "",
        name: "",
        description: "",
        favSelected: nil
      )
    ]
    
    //when
    sut.getFavouriteMobiles(request: TabAll.ShowFavouritesTab.Request())
    
    //then
    XCTAssertTrue(presenterSpy.presentDataCalled)
  }
  
  func testDidTapSetFavouriteButtonCaseSuccess() {
     //given
    sut.dataArray = [
      MobileList(
        rating: 0.0,
        id: 55,
        thumbImageURL: "",
        price: 0.0,
        brand: "",
        name: "",
        description: "",
        favSelected: false
      ),
      MobileList(
        rating: 0.0,
        id: 80,
        thumbImageURL: "",
        price: 0.0,
        brand: "",
        name: "",
        description: "",
        favSelected: false
      )
    ]
    let mobileID: Int = 55
    let isFav: Bool = true
    
    //when
    sut.setFavourite(request: TabAll.SetFavData.Request(mobileID: mobileID, isFav: isFav))
    
    //then
    XCTAssertEqual(sut.dataArray[0].favSelected, true)
  }
  
  
  func testSortingPriceHighToLowTabAllToshowResultInPresenterCaseSuccess() {
    //given
    let presenterSpy = TabAllPresenterSpy()
    sut.presenter = presenterSpy
    let btnTagSelected = 0
    sut.dataArray = sutMobileList
    
    //when
    sut.getSorting(resquest: TabAll.SortTable.Request(sortType: .PriceHightToLow, BtntagSelected: btnTagSelected))
  
    //then
    XCTAssertTrue(presenterSpy.presentDataCalled)
    XCTAssertEqual(sut.dataArray[0].price, 300.0)
  }
  
   func testSortingPriceLowToHighTabAllToshowResultInPresenterCaseSuccess() {
    //given
    let presenterSpy = TabAllPresenterSpy()
    sut.presenter = presenterSpy
    let btnTagSelected = 0
    sut.dataArray = sutMobileList
    
    //when
    sut.getSorting(resquest: TabAll.SortTable.Request(sortType: .PriceLowToHight, BtntagSelected: btnTagSelected))
    
    //then
    XCTAssertTrue(presenterSpy.presentDataCalled)
    XCTAssertEqual(sut.dataArray[0].price, 100.0)
    
  }
  
  func testSortingRatingHighToLowTabAllToshowResultInPresenterCaseSuccess()
  {
    //given
    let presenterSpy = TabAllPresenterSpy()
    sut.presenter = presenterSpy
    let btnTagSelected = 0
    sut.dataArray = sutMobileList
    
    //when
    sut.getSorting(resquest: TabAll.SortTable.Request(sortType: .RatingHightToLow, BtntagSelected: btnTagSelected))
    
    //then
    XCTAssertTrue(presenterSpy.presentDataCalled)
    XCTAssertEqual(sut.dataArray[0].rating, 5)
  }
  
  func testSortingPriceHighToLowTabFavouriteToshowResultInPresenterCaseSuccess() {
    //given
    let presenterSpy = TabAllPresenterSpy()
    sut.presenter = presenterSpy
    let btnTagSelected = 1
    sut.dataArray = sutMobileList
    
    //when
    sut.getSorting(resquest: TabAll.SortTable.Request(sortType: .PriceHightToLow, BtntagSelected: btnTagSelected))
    
    //then
    XCTAssertTrue(presenterSpy.presentDataCalled)
    XCTAssertEqual(sut.dataArray[0].price, 300.0)
  }
  
  
  func testSortingPriceLowToHighTabFavouriteToshowResultInPresenterCaseSuccess() {
    //given
    let presenterSpy = TabAllPresenterSpy()
    sut.presenter = presenterSpy
    let btnTagSelected = 1
    sut.dataArray = sutMobileList
    
    //when
    sut.getSorting(resquest: TabAll.SortTable.Request(sortType: .PriceLowToHight, BtntagSelected: btnTagSelected))
    
    //then
    XCTAssertTrue(presenterSpy.presentDataCalled)
    XCTAssertEqual(sut.dataArray[0].price, 100.0)
    
  }
  
  func testSortingRatingHighToLowTabFavouriteToshowResultInPresenterCaseSuccess()
  {
    //given
    let presenterSpy = TabAllPresenterSpy()
    sut.presenter = presenterSpy
    let btnTagSelected = 1
    sut.dataArray = sutMobileList
    
    //when
    sut.getSorting(resquest: TabAll.SortTable.Request(sortType: .RatingHightToLow, BtntagSelected: btnTagSelected))
    
    //then
    XCTAssertTrue(presenterSpy.presentDataCalled)
    XCTAssertEqual(sut.dataArray[0].rating, 5)
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
