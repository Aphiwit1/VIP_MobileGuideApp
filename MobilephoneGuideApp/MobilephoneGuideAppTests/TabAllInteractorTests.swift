//
//  TabAllInteractorTests.swift
//  MobilephoneGuideApp
//
//  Created by AphiwitSCB on 4/9/2562 BE.
//  Copyright (c) 2562 OnceKB. All rights reserved.
//

@testable import MobilephoneGuideApp
import XCTest

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

  func testSomething() {
    // Given
    
    // When
    
    // Then
  }
  
  class TabAllWorkerSpy: TabAllWorker{
    // MARK: Method call expectations
    var fetchApiCalled = false
    
    // MARK: Spied methods
//    override func fetchApi(completionHandler: @escaping ([MobileList]) -> Void)
//    {
//      fetchOrdersCalled = true
//    }
    
    
  }
  
  func testFetchApiShouldAskTabAllWorkerToFetchApiPresenterToShowResult()
  {
    // Given
    
    // When
    
    // Then
  }
}
