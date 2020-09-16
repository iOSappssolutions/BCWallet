//
//  CurrencyDef.swift
//  BCWalletModel
//
//  Created by Miroslav Djukic on 22/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

public protocol CurrencyDef {
    var symbol: String { get }
    var code: String { get }
    var commonUnit: CurrencyUnit { get }
    var symbolIsLeft: Bool { get }
    var rate: Double { get }
}

public protocol CurrencyUnit {
    /// Base unit (e.g. Satoshis) multiplier, as a power of 10
    var decimals: Int { get }
    var name: String { get }
}

public extension CurrencyUnit where Self: RawRepresentable, Self.RawValue == Int {
    var decimals: Int { return rawValue }
    var name: String { return String(describing: self) }
}


// hardcoded for simplicty could be also pulled from api 
public struct Bitcoin: CurrencyDef {

    public enum Units: Int, CurrencyUnit {
        case satoshi = 0
        case bitcoin = 8 // 1 Satoshi = 1e-8 BTC
    }
    
    public var commonUnit: CurrencyUnit {
        return Units.bitcoin
    }
    
    public let symbol = "BTC"
    public let code = "BTC"
    public let symbolIsLeft = false
    public let rate = 1.0
}

public struct FiatCurrency: CurrencyDef {

    public enum Units: Int, CurrencyUnit {
        case baseUnit = 2
    }
    
    public var commonUnit: CurrencyUnit {
        return Units.baseUnit
    }
    
    public let symbol: String //= "$"
    public let code: String //= "USD"
    public let symbolIsLeft: Bool //= true
    public let rate: Double
}
