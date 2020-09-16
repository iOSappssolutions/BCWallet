//
//  XPubViewModelTests.swift
//  BCWalletModelTests
//
//  Created by Miroslav Djukic on 21/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import XCTest

import Combine
@testable import BCWalletModel

class XPubViewModelTests: XCTestCase {
    
    var xPubViewModel: XPubViewModel!
    var fiatCurrency: CurrencyDef!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        fiatCurrency = FiatCurrency(symbol: "$", code: "USD", symbolIsLeft: true, rate: 10714.42729779)
        xPubViewModel = BCWalletModelFactory.makeXPubViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetching() throws {
        
        XCTAssertNil(xPubViewModel.alertMessage, "alert should be nil")
        XCTAssertEqual(xPubViewModel.isLoading, false, "is loading should be nil")
        XCTAssertEqual(xPubViewModel.transactions.count == 0, true, "transactions array should be empty")
        
        xPubViewModel.fetchWalletData(xPub: "")
        
        XCTAssertNotNil(xPubViewModel.alertMessage, "alert shouldn't be nil after failed fetch")
        
        xPubViewModel.fetchWalletData(xPub: "xpub6CfLQa8fLgtouvLxrb8EtvjbXfoC1yqzH6YbTJw4dP7srt523AhcMV8Uh4K3TWSHz9oDWmn9MuJogzdGU3ncxkBsAC9wFBLmFrWT9Ek81kQ")
        
        XCTAssertEqual(xPubViewModel.transactions.count == 0, true, "transactions array should be empty")
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testWallentBalance() throws {
        xPubViewModel.walletBalanceSatoshi = 459
        
        let walletBalanceInBtc = xPubViewModel.walletBalanceBTCText
        
        XCTAssertEqual(walletBalanceInBtc, "0.00000459 BTC", "format not correct")
    }
    
    func testWallentBalanceFiatCurrency() throws {
        xPubViewModel.walletBalanceSatoshi = -4035
        xPubViewModel.fiatCurrency = fiatCurrency
        
        let walletBalanceInBtc = xPubViewModel.walletBalanceFiatText
        
        let currentSystemDelimiter = NumberFormatter().decimalSeparator ?? "."
        XCTAssertEqual(walletBalanceInBtc,"$ 0\(currentSystemDelimiter)38", "incorrect status")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
