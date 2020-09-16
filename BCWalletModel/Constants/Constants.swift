//
//  Constants.swift
//  BCWalletModel
//
//  Created by Miroslav Djukic on 20/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

public struct C {
    
    // MARK: Base URL
    
    static let baseURL = "https://blockchain.info/"
    
    // MARK: Endpoints
    
    static let xPubEndpoint = "multiaddr"
    
    // MARK: String constants
    
    public static let send = "Send"
    public static let receive = "Receive"
    
    public static let sentTo = "Sent to:"
    public static let receivedOn = "Received on:"
    
    public static let complete = "Complete"
    public static let pending = "Pending"
    public static let doubleSpent = "Double spent"
    
}
