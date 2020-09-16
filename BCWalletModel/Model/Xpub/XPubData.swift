//
//  XpubData.swift
//  BCWalletModel
//
//  Created by Miroslav Djukic on 20/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

struct XPubData: Decodable {
    let addresses: [Address]?
    let wallet: Wallet
    let transactions: [Transaction]
    let info: Info
    let reccomendIncludeFee: Bool?
    
    enum CodingKeys: String, CodingKey {
        case addresses = "addresses"
        case wallet = "wallet"
        case transactions = "txs"
        case info = "info"
        case reccomendIncludeFee = "recommend_include_fee"
    }
}



