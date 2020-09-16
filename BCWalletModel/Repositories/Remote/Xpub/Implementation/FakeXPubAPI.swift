//
//  FakeXPubAPI.swift
//  BCWalletModel
//
//  Created by Miroslav Djukic on 20/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import Combine

class FakeXPubAPI: XPubAPI {
    
    public var baseURL: String = C.baseURL
    
    public var session: URLSession = URLSession.configuredURLSession()
    
    func fetchWalletData(xPub: String) -> AnyPublisher<XPubData, Error> {
        if(xPub == "") {
            return Fail<XPubData, Error>(error: APIError.unexpectedResponse).eraseToAnyPublisher()
        } else {
            return Empty<XPubData, Error>().eraseToAnyPublisher()
        }
    }

    public init() { }
}
