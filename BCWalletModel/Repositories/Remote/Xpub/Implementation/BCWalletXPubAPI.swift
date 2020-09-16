//
//  BCWalletXPubAPI.swift
//  BCWalletModel
//
//  Created by Miroslav Djukic on 20/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import Combine

struct BCWalletXPubAPI: XPubAPI {
    
    public var baseURL: String = C.baseURL
    
    public var session: URLSession = URLSession.configuredURLSession()
    
    // MARK: xPub endpoint calls
    
    func fetchWalletData(xPub: String) -> AnyPublisher<XPubData, Error> {
        return call(endpoint: API.fetchWalletData(xPub))
    }

    public init() { }
    
}

// MARK: Donation endpoint types

extension BCWalletXPubAPI {
    
    enum API {
        case fetchWalletData(String)
    }
    
}

// MARK: Request settings

extension BCWalletXPubAPI.API: APICall {
    
    var path: String {
        switch self {
        case .fetchWalletData:
            return C.xPubEndpoint
        }
    }
    
    var method: String {
        switch self {
        case .fetchWalletData:
            return "GET"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case let .fetchWalletData(xPub):
            return [URLQueryItem(name: "active", value: xPub)]
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json", "accept": "application/json"]
    }
    
    func body() throws -> Data? {
        // just example how would be used for adding body, for this instance nil
        
        return nil
    }
    
   
    
}
