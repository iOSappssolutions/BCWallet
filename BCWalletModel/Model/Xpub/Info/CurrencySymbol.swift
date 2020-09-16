//
//  BTCSymbol.swift
//  BCWalletModel
//
//  Created by Miroslav Djukic on 20/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

struct CurrencySymbol: Decodable {
    let code: String
    let symbol: String
    let name: String?
    let conversion: Double
    let symbolAppearsAfter: Bool
    let local: Bool?
}
