//
//  URLSession+extension.swift
//  BCWalletModel
//
//  Created by Miroslav Djukic on 22/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

extension URLSession {
    static func configuredURLSession() -> URLSession {
       let configuration = URLSessionConfiguration.default
       configuration.timeoutIntervalForRequest = 60
       configuration.timeoutIntervalForResource = 120
       configuration.waitsForConnectivity = true
       configuration.httpMaximumConnectionsPerHost = 5
       return URLSession(configuration: configuration)
    }
}
