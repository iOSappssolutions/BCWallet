//
//  XPubViewModel.swift
//  BCWalletModel
//
//  Created by Miroslav Djukic on 20/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import Combine

public final class XPubViewModel: ObservableObject {
    
    @Published public var isLoading: Bool = false
    @Published public var alertMessage: Message? = nil
    @Published public var transactions: [TransactionViewModel] = []
    
    private let currency = Bitcoin()
    public var fiatCurrency: CurrencyDef?
    public var walletBalanceSatoshi: Int? = nil
    
    public var walletBalanceBTCText: String {
        guard let satoshis = walletBalanceSatoshi else {
            return ""
        }
        let amount = Amount(amount: satoshis, currency: currency)
        return amount.commonUnitString
    }
    
    public var walletBalanceFiatText: String {
        
        guard let fiatCurrency = fiatCurrency else {
            return ""
        }
        
        guard let satoshis = walletBalanceSatoshi else {
            return ""
        }
        
        let amount = Amount(amount: satoshis, currency: currency)
        return amount.getFiatCurrencyCommonUnitString(fiatCurrency: fiatCurrency)
    }
    
    private let xPubAPI: XPubAPI
    private var subscriptions = Set<AnyCancellable>()
    
    
    
    init(xPubAPI: XPubAPI) {
        self.xPubAPI = xPubAPI
    }
    
    public func fetchWalletData(xPub: String) {
        isLoading = true
        xPubAPI.fetchWalletData(xPub: xPub)
        .sink(receiveCompletion: { [weak self] in
            if case .failure(let error) = $0 {
                self?.alertMessage = Message(id: 0, message: error.localizedDescription)
            }
            self?.isLoading = false
        }) { [weak self] (xPubResponse) in
            guard let self = self else { return }
            
            self.walletBalanceSatoshi = xPubResponse.wallet.finalBalance
            self.fiatCurrency = FiatCurrency(symbol: xPubResponse.info.symbolLocal.symbol,
                                            code: xPubResponse.info.symbolLocal.code,
                                            symbolIsLeft: !xPubResponse.info.symbolLocal.symbolAppearsAfter,
                                            rate: xPubResponse.info.symbolLocal.conversion)
            
            self.transactions = xPubResponse.transactions.map({ TransactionViewModel(currency: self.currency,
                                                                                     fiatCurrency: self.fiatCurrency!,
                                                                                      transaction: $0,
                                                                                      latestBlockHeight: xPubResponse.info.latestBlock.height) })
        }
        .store(in: &subscriptions)
        
    }
    
}


public struct Message: Identifiable {
    public var id: Int
    public let message: String
}
