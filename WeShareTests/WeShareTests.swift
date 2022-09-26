//
//  WeShareTests.swift
//  WeShareTests
//
//  Created by Emmanuel George on 03/09/22.
//
import XCTest

@testable import WeShare
import UIKit
class WeShareTests: XCTestCase {
    
    //Api Testing
    var posts = [PostData]()
    func testFetchPost(){
        let exp = expectation(description: "Check post retrival is successful")
  
        RestServices.shared.fetchPosts { res in
            switch res {
            case .failure(let err):
                print("Failed to fetch post:",err)
            case .success(let posts):
                self.posts = posts
                exp.fulfill()
            }
       
        }
        waitForExpectations(timeout: 30) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
                //to see the test getting failed go to RestViewModel and manualy corrupt the url or decreases
                //the timeout to 0, dont forget to change it back :)
            }
            XCTAssertNotNil(self.posts,"posts retreved")
           // XCTAssertNil(self.posts,"will Fail")
        }
    }
    
    //Functional Testing
    
    var comment = [PostComment]()
    var sortedComment = [PostComment]()
    var detailedVC = DetailedViewController()
    func testFetchCommentAndSorting(){
        let exp = expectation(description: "Check Comments retrival is successful")
  
        RestServices.shared.fetchComments(userId: 1) { res in
            switch res {
            case .failure(let err):
                print("Failed to fetch Comments:",err)
            case .success(let comment):
                self.comment = comment
                exp.fulfill()
              
            }
       
        }
        waitForExpectations(timeout: 30) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
                //to see the test getting failed go to RestViewModel and manualy corrupt the url or decreases
                //the timeout to 0, dont forget to change it back :)
            }
            XCTAssertNotNil(self.comment,"Comments retreved")
           // XCTAssertNil(self.comment,"Error comments did't retreved")
            //sorteding array by ID
            self.sortedComment = self.detailedVC.sortingData(array: self.comment)
            
            XCTAssertNotNil(self.sortedComment,"Comments sorted by id in decending order")
           // XCTAssertNil(self.sortedComment,"Error Comments did't get sorted")

        }
    }
}
