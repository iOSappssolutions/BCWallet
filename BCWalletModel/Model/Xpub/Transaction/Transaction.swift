//
//  Transactions.swift
//  BCWalletModel
//
//  Created by Miroslav Djukic on 20/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

struct Transaction: Decodable {
    
    let hash: String
    let version: Int?
    let vInSZ: Int?
    let vOutSZ: Int?
    let size: Int?
    let weight: Int?
    let fee: Int
    let relayedBy: String?
    let lockTime: Int?
    let txIndex: Int?
    let doubleSpend: Bool?
    let result: Int
    let balance: Int?
    let time: Int
    let blockIndex: Int?
    let blockHeight: Int
    let inputs: [TxInput]
    let outputs: [TxOutput]
    
    enum CodingKeys: String, CodingKey {
        case hash = "hash"
        case version = "ver"
        case vInSZ = "vin_sz"
        case vOutSZ = "vout_sz"
        case size = "size"
        case weight = "weight"
        case fee = "fee"
        case relayedBy = "relayed_by"
        case lockTime = "lock_time"
        case txIndex = "tx_index"
        case doubleSpend = "double_spend"
        case result = "result"
        case balance = "balance"
        case time = "time"
        case blockIndex = "block_index"
        case blockHeight = "block_height"
        case inputs = "inputs"
        case outputs = "out"
    }
    
}

