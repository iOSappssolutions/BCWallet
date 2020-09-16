//
//  TransactionViewModel.swift
//  BCWalletModel
//
//  Created by Miroslav Djukic on 21/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

public struct TransactionViewModel: Identifiable {
    
    
    private let transaction: Transaction
    private let latestBlockHeight: Int
    private let currency: CurrencyDef
    private let fiatCurrency: CurrencyDef
    
    init(currency: CurrencyDef,
         fiatCurrency: CurrencyDef,
         transaction: Transaction,
         latestBlockHeight: Int) {
        
        self.currency = currency
        self.transaction = transaction
        self.latestBlockHeight = latestBlockHeight
        self.fiatCurrency = fiatCurrency
    }
    
    public var id: String {
        return transaction.hash
    }
    
    // if negative amount it's outgoing otherwise incoming
    public var direction: Direction {
        return transaction.result < 0 ? .outgoing : .incoming
    }
    
    public var txStatusText: String {
        var text: String
        
        switch self.txStatus {
        case .complete:
            text = C.complete
        case .pending:
            text = C.pending
        case .doubleSpend:
            text = C.doubleSpent
        }
        return text
        
    }
    
    public var shortDescriptionText: String {
        return direction == .outgoing ? "\(C.send) \(currency.code)" : "\(C.receive) \(currency.code)"
    }
    
    // btc amount string format
    public var btcAmountText: String {
        let amount = Amount(amount: transaction.result, currency: currency)
        return amount.commonUnitString
    }
    
    // $ (or any other local) amount string format
    public var fiatCurrencyAmountText: String {
        let amount = Amount(amount: transaction.result, currency: currency)
        return amount.getFiatCurrencyCommonUnitString(fiatCurrency: fiatCurrency)
    }
    
    // date formmated in short for list
    public var shortDate: String {
        let date = Date(timeIntervalSince1970: TimeInterval(transaction.time))
        let formattedDate = shortDateFormatter.string(from: date)
        return formattedDate
    }
    
    // tx hash
    public var transactionID: String {
        return transaction.hash
    }
    
    // fee in BTC
    public var fee: String {
        let amount = Amount(amount: transaction.fee, currency: currency)
        return amount.commonUnitString
    }
    
    // long date format for tx details
    public var longDate: String {
        let date = Date(timeIntervalSince1970: TimeInterval(transaction.time))
        let formattedDate = longDateFormatter.string(from: date)
        return formattedDate
    }
    
    // display label according to transaction direction
    public var addressInfoText: String {
        return direction == .outgoing ? C.sentTo : C.receivedOn
    }
    
    // if transaction is outgoing show address coins were sent to otherwise show address coins were received on
    public var displayAddress: String {
        return direction == .outgoing ? toAddress : onAddress
    }
    
    // if more than 6 blocks went from transaction it is considered completed, if double spent mark as double spend
    private var txStatus: TxStatus {
        var status: TxStatus
        if(transaction.doubleSpend ?? false) {
            status = .doubleSpend
        } else if transaction.blockHeight + 6 <= latestBlockHeight {
            status = .complete
        } else {
            status = .pending
        }
        return status
    }
    
    // address that coins were sent to
    private var toAddress: String {
        let absoluteAmount = abs(transaction.result)
        guard let output = transaction.outputs.first(where: { $0.value + transaction.fee - absoluteAmount == 0 }) else { return "" }
        return output.address
    }
    
    // address on which coins were received
    private var onAddress: String {
        let absoluteAmount = abs(transaction.result)
        guard let output = transaction.outputs.first(where: { $0.value - absoluteAmount == 0 }) else { return "" }
        return output.address
    }

}

public enum Direction {
    case incoming
    case outgoing
}

public enum TxStatus {
    case complete
    case pending
    case doubleSpend
}
