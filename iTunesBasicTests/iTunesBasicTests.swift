//
// iTunesBasicTests.swift
// iTunesBasicTests
//
// Created on 20.02.2022.
// Oguzhan Yalcin
//
//
//


import XCTest
@testable import iTunesBasic

class iTunesBasicTests: XCTestCase {
    
    func testHandleFormattedDate() {
        let date = "2002-11-06T05:20:05Z".toDate()
        let dateString = date.toString(formatType: "dd-MM-yyyy")
        
        XCTAssertEqual(dateString, "06-11-2002")
    }
    
    func testHandleFormattedCurrency() {
        XCTAssertEqual("USD".handleCurrencyFormat(), "$")
        XCTAssertEqual("EURO".handleCurrencyFormat(), "€")
        XCTAssertEqual("TRY".handleCurrencyFormat(), "₺")
        XCTAssertEqual("STERLIN".handleCurrencyFormat(), "£")
    }
    
    func testCalculateTextWidth() {
        let text = "iTunes Basic Test"
        
        XCTAssertNotNil(text.returnWidth())
    }
    
    func testHandleReplacedText() {
        let text = "No Need Empty Spaces"
        let replacedText = text.replace(string: " ", replacement: "")
        
        XCTAssertEqual(replacedText, "NoNeedEmptySpaces")
    }
    
    func testRequestStoreAPI() {
        let request = StorePost(term: "john", country: "TR", limit: 20)
        
        ServiceManager.shared.getStoreItems(term: request.term!, country: request.country!, limit: request.limit!) { response, isOK in
            
            XCTAssertNotNil(response)
            XCTAssertTrue(isOK)
        }
        
    }
}
