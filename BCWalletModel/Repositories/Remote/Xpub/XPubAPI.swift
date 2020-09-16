//
//  XpubAPI.swift
//  BCWalletModel
//
//  Created by Miroslav Djukic on 20/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import Combine

protocol XPubAPI: WebRepository {
    
    func fetchWalletData(xPub: String) -> AnyPublisher<XPubData, Error>
    
}


