//
//  TabAllInteractorTests.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 4/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

@testable import MobilephoneGuideApp
import XCTest
import Alamofire
import AlamofireImage

enum TestError : Error {
  case fail
}

class TabAllInteractorTests: XCTestCase {
  
  // MARK: - Subject under test
  
  var sut: TabAllInteractor!
  
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
  
  class TabAllWorkerSpy: TabAllWorker{
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
  
  class TabAllPresenterSpy: TabAllPresenterInterface {
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
        id: 1,
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
  
  
  
  
  
}
