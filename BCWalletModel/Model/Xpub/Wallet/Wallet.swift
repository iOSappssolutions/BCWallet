//
//  Wallet.swift
//  BCWalletModel
//
//  Created by Miroslav Djukic on 20/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

struct Wallet: Decodable {
    let finalBalance: Int
    let nTx: Int?
    let nTxFiltered: Int?
    let totalReceived: Int?
    let totalSent:Int?
    
    enum CodingKeys: String, CodingKey {
        case finalBalance = "final_balance"
        case nTx = "n_tx"
        case nTxFiltered = "n_tx_filtered"
        case totalReceived = "total_received"
        case totalSent = "total_sent"
    }
}
