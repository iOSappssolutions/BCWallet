//
//  TxInput.swift
//  BCWalletModel
//
//  Created by Miroslav Djukic on 20/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

struct TxInput: Decodable {
    let sequence: Int?
    let witness: String?
    let script: String?
    let index: Int?
    let prevOut: TxOutput?
    
    enum CodingKeys: String, CodingKey {
        case sequence = "sequence"
        case witness = "witness"
        case script = "script"
        case index = "index"
        case prevOut = "prev_out"
    }
}
