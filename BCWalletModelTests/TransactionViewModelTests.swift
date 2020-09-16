//
//  BCWalletModelTests.swift
//  BCWalletModelTests
//
//  Created by Miroslav Djukic on 20/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import XCTest
@testable import BCWalletModel

class TransactionViewModelTests: XCTestCase {
    
    var sentTransactionViewModel: TransactionViewModel!
    var receivedTransactionViewModel: TransactionViewModel!
    var doubleSpentMockTransactionViewModel: TransactionViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        let fiatCurrency = FiatCurrency(symbol: "$", code: "USD", symbolIsLeft: true, rate: 10714.42729779)
        
        let mockTxOutput1 = TxOutput(value: 1549, address: "19gyqBkY8v5jj5R8QPACxSW95mtkv1nE1n")
        let mockTxOutput2 = TxOutput(value: 10958, address: "171RCdgHL4RkZjUZg6LRoEPQBgT15Sv173")
        let sentMockTransaction = Transaction(hash: "fdb73fa90b954cdae298b86653c0a5c0bc3f82c18ba00e2dad071258a878ac74",
                                          fee: 2486,
                                          result: -4035,
                                          time: 1541530187,
                                          blockHeight: 549036,
                                          doubleSpend: false,
                                          txOutputs: [mockTxOutput1, mockTxOutput2])
        
        sentTransactionViewModel = TransactionViewModel(currency: Bitcoin(),
                                                        fiatCurrency: fiatCurrency,
                                                        transaction: sentMockTransaction,
                                                        latestBlockHeight: 549042)
        
        let mockTxOutput3 = TxOutput(value: 15389, address: "18XfyNe4FHPw8RZLpi7KK27pyKwVZo9og2")
        let receivedMockTransaction = Transaction(hash: "c83e338f8fd064eee481eb346694a4dc8b5c2afd1117ce8321f75b394c746668",
                                          fee: 678,
                                          result: 15389,
                                          time: 1540207704,
                                          blockHeight: 546856,
                                          doubleSpend: false,
                                          txOutputs: [mockTxOutput3])
        
        receivedTransactionViewModel = TransactionViewModel(currency: Bitcoin(),
                                                            fiatCurrency: fiatCurrency,
                                                            transaction: receivedMockTransaction,
                                                            latestBlockHeight: 546861)
        
        let doubleSpentMockTransaction = Transaction(hash: "c83e338f8fd064eee481eb346694a4dc8b5c2afd1117ce8321f75b394c746668",
                                          fee: 678,
                                          result: 15389,
                                          time: 1540207704,
                                          blockHeight: 546856,
                                          doubleSpend: true,
                                          txOutputs: [mockTxOutput3])
        
        doubleSpentMockTransactionViewModel = TransactionViewModel(currency: Bitcoin(),
                                                                   fiatCurrency: fiatCurrency,
                                                                   transaction: doubleSpentMockTransaction,
                                                                   latestBlockHeight: 546861)
    }

    override func tearDownWithError() throws {

        sentTransactionViewModel = nil
        receivedTransactionViewModel = nil
        
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTransactionHash() throws {
        let sentTxHash = sentTransactionViewModel.transactionID
        
        XCTAssertEqual(sentTxHash, "fdb73fa90b954cdae298b86653c0a5c0bc3f82c18ba00e2dad071258a878ac74", "incorrect sent Tx hash")
        
        let receiveTxHash = receivedTransactionViewModel.transactionID
        
        XCTAssertEqual(receiveTxHash, "c83e338f8fd064eee481eb346694a4dc8b5c2afd1117ce8321f75b394c746668", "incorrect received Tx hash")
        
    }
    
    func testTransactionDirection() throws {
        
        let sentTxDirection = sentTransactionViewModel.direction
        
        XCTAssertEqual(sentTxDirection, .outgoing, "incorrect tx direction")
        
        let receivedTxDirection = receivedTransactionViewModel.direction
        
        XCTAssertEqual(receivedTxDirection, .incoming, "incorrect tx direction")
        
    }
    
    func testShortDescriptionText() throws {
        
        let sendTxShortDescriptionText = sentTransactionViewModel.shortDescriptionText
        
        XCTAssertEqual(sendTxShortDescriptionText, "\(C.send) BTC", "incorrect short description code")
        
        let receiveShortDescriptionText = receivedTransactionViewModel.shortDescriptionText
        
        XCTAssertEqual(receiveShortDescriptionText, "\(C.receive) BTC", "incorrect short description code")
        
    }
    
    func testBtcAmountText() throws {
        let sendTxBTCAmountText = sentTransactionViewModel.btcAmountText
        let currentSystemDelimiter = NumberFormatter().decimalSeparator ?? "."
        
        XCTAssertEqual(sendTxBTCAmountText, "0\(currentSystemDelimiter)00004035 BTC", "incorrect btc amount format")
        
        let receivedBTCAmountText = receivedTransactionViewModel.btcAmountText
        
        XCTAssertEqual(receivedBTCAmountText, "0\(currentSystemDelimiter)00015389 BTC", "incorrect btc amount format")
    }
    
    func testShortDate() throws {
        
        let sendShortDate = sentTransactionViewModel.shortDate
        
        XCTAssertEqual(sendShortDate, "06 Nov 2018", "incorrect short date format or value")
        
        let receovedShortDate = receivedTransactionViewModel.shortDate
        
        XCTAssertEqual(receovedShortDate, "22 Oct 2018", "incorrect short date format or value")
        
        
    }
    
    func testTransactionID() throws {
        let sendTxID = sentTransactionViewModel.id
        
        XCTAssertEqual(sendTxID, "fdb73fa90b954cdae298b86653c0a5c0bc3f82c18ba00e2dad071258a878ac74", "incorrect tx id")
        
        let receiveTxID = receivedTransactionViewModel.id
        
        XCTAssertEqual(receiveTxID, "c83e338f8fd064eee481eb346694a4dc8b5c2afd1117ce8321f75b394c746668", "incorrect tx id")
    }
    
    func testFee() throws {
        let sendTxFee = sentTransactionViewModel.fee
        let currentSystemDelimiter = NumberFormatter().decimalSeparator ?? "."
        XCTAssertEqual(sendTxFee, "0\(currentSystemDelimiter)00002486 BTC", "incorrect fee amount format")
        
        let receiveTxFee = receivedTransactionViewModel.fee
        XCTAssertEqual(receiveTxFee, "0\(currentSystemDelimiter)00000678 BTC", "incorrect fee amount format")
    }
    
    func testLongDate() throws {
        let sendTxLongDate = sentTransactionViewModel.longDate
        XCTAssertEqual(sendTxLongDate, "Nov 06, 2018 @ 07:49 PM", "incorrect long date")
        
    }
    
    func testAddressInfoText() throws {
        let sentAddressInfoText = sentTransactionViewModel.addressInfoText
        XCTAssertEqual(sentAddressInfoText, C.sentTo, "incorrect address info text")
        
        let receivedAddressInfoText = receivedTransactionViewModel.addressInfoText
         XCTAssertEqual(receivedAddressInfoText, C.receivedOn, "incorrect address info text")
    }
    
    func testDisplayAddress() throws {
        let sentDisplayAddress = sentTransactionViewModel.displayAddress
        XCTAssertEqual(sentDisplayAddress, "19gyqBkY8v5jj5R8QPACxSW95mtkv1nE1n", "incorrect display address")
        
        let receivedDisplayAddress = receivedTransactionViewModel.displayAddress
        XCTAssertEqual(receivedDisplayAddress, "18XfyNe4FHPw8RZLpi7KK27pyKwVZo9og2", "incorrect display address")
    }
    
    func testTransactionStatus() throws {
        let status1 = sentTransactionViewModel.txStatusText
        XCTAssertEqual(status1, C.complete, "incorrect status")
        
        let status2 = receivedTransactionViewModel.txStatusText
        XCTAssertEqual(status2, C.pending, "incorrect status")
        
        let statys3 = doubleSpentMockTransactionViewModel.txStatusText
        XCTAssertEqual(statys3, C.doubleSpent, "incorrect status")
        
    }
    
    func testFiatAmountFormat() throws {
        let fiatAmountFormattedString = sentTransactionViewModel.fiatCurrencyAmountText
        let currentSystemDelimiter = NumberFormatter().decimalSeparator ?? "."
        XCTAssertEqual(fiatAmountFormattedString,"$ 0\(currentSystemDelimiter)38", "incorrect status")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

// convinience init for testing purposes
extension TxOutput {
    init(value: Int,
         address: String) {
        
        self.init(type: nil,
                  spent: nil,
                  value: value,
                  address: address,
                  n: nil,
                  txIndex: nil,
                  script: nil,
                  spendingOutpoints: nil,
                  xPub: nil)
        
    }
}


// convinience init for testing purposes
extension Transaction {
    init(hash: String,
         fee: Int,
         result: Int,
         time: Int,
         blockHeight: Int,
         doubleSpend: Bool,
         txOutputs: [TxOutput]) {
        
        self.init(hash: hash,
                  version: nil,
                  vInSZ: nil,
                  vOutSZ: nil,
                  size: nil,
                  weight: nil,
                  fee: fee,
                  relayedBy: nil,
                  lockTime: nil,
                  txIndex: nil,
                  doubleSpend: doubleSpend,
                  result: result,
                  balance: nil,
                  time: time,
                  blockIndex: nil,
                  blockHeight: blockHeight,
                  inputs: [],
                  outputs: txOutputs)
        
    }
}
