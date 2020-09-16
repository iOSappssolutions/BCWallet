//
//  Info.swift
//  BCWalletModel
//
//  Created by Miroslav Djukic on 20/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

struct Info: Decodable {
    let nconnected: Int?
    let conversion: Double?
    let symbolLocal: CurrencySymbol
    let symbolBTC: CurrencySymbol
    let latestBlock: Block
    
    
    enum CodingKeys: String, CodingKey {
        case nconnected = "nconnected"
        case conversion = "conversion"
        case symbolBTC = "symbol_btc"
        case symbolLocal = "symbol_local"
        case latestBlock = "latest_block"
    }
}
