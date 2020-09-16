//
//  Address.swift
//  BCWalletModel
//
//  Created by Miroslav Djukic on 20/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

struct Address: Decodable {
    let address: String?
    let finalBalance: Int?
    let changeIndex: Int?
    let accountIndex: Int?
    let nTx: Int?
    let totalReceived: Int?
    let totalSent: Int?
    
    enum CodingKeys: String, CodingKey {
        case address = "address"
        case finalBalance = "final_balance"
        case changeIndex = "change_index"
        case accountIndex = "account_index"
        case nTx = "n_tx"
        case totalReceived = "total_received"
        case totalSent = "total_sent"
    }
}
