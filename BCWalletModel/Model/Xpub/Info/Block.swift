//
//  Block.swift
//  BCWalletModel
//
//  Created by Miroslav Djukic on 20/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

struct Block: Decodable {
    
    let hash: String?
    let height: Int
    let time: Int?
    let blockIndex: Int?
    
    enum CodingKeys: String, CodingKey {
        case hash = "hash"
        case height = "height"
        case time = "time"
        case blockIndex = "block_index"
    }
}
