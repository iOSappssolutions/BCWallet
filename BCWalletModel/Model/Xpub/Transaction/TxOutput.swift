//
//  TxOutput.swift
//  BCWalletModel
//
//  Created by Miroslav Djukic on 20/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

struct TxOutput: Decodable {
    let type: Int?
    let spent: Bool?
    let value: Int
    let address: String
    let n: Int?
    let txIndex: Int?
    let script: String?
    let spendingOutpoints: [SpendingOutpoints]?
    let xPub: XPub?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case spent = "spent"
        case value = "value"
        case spendingOutpoints = "spending_outpoints"
        case address = "addr"
        case n = "n"
        case txIndex = "tx_index"
        case script = "script"
        case xPub = "xpub"
    }
    
}

struct XPub: Decodable {
    let m: String
    let path: String
}

struct SpendingOutpoints: Decodable {
    let txIndex: Int
    let n: Int
    
    enum CodingKeys: String, CodingKey {
        case txIndex = "tx_index"
        case n = "n"
    }
}
