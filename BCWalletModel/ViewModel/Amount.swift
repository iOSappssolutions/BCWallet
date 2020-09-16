//
//  Amount.swift
//  BCWalletModel
//
//  Created by Miroslav Djukic on 22/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

struct Amount {

    let minimumFractionDigits: Int
    let maximumFractionDigits: Int
    let amount: Int
    let currency: CurrencyDef
    
    // format for cryptocurrency
    var amountFormat: NumberFormatter {
        let format = NumberFormatter()
        format.isLenient = true
        format.generatesDecimalNumbers = true
        format.maximumFractionDigits = maximumFractionDigits
        format.minimumFractionDigits = minimumFractionDigits
        format.minimumIntegerDigits = 1
        format.maximumIntegerDigits = 9
        format.usesGroupingSeparator = false
        return format
    }
    
    
    init(amount: Int,
         currency: CurrencyDef) {
        
        self.amount = amount
        self.currency = currency
        self.maximumFractionDigits = currency.commonUnit.decimals
        self.minimumFractionDigits = currency.commonUnit.decimals
    }
    
    // String formated for amount in common unit for crypto currency type
    var commonUnitString: String {
        let commonUnitAmountValue = commonUnitAmount
        var formattedAmount = ""
        if(amount == 0) {
            formattedAmount = "0"
        } else {
            formattedAmount = amountFormat.string(from: commonUnitAmountValue) ?? ""
        }
        
        if(currency.symbolIsLeft) {
            return "\(currency.symbol) \(formattedAmount)"
        } else {
            return "\(formattedAmount) \(currency.symbol)"
        }
        
    }
    
    // amount in common unit for cryptocurrency
    var commonUnitAmount: NSDecimalNumber {
        NSDecimalNumber(integerLiteral: abs(amount))
            .dividing(by: NSDecimalNumber(floatLiteral: pow(10, Double(amountFormat.minimumFractionDigits))))
    }
    
    // formatted string for fiat currancy in it's currency format
    func getFiatCurrencyCommonUnitString(fiatCurrency: CurrencyDef) -> String {
        let fiatCurrencyFormat = NumberFormatter()
        fiatCurrencyFormat.generatesDecimalNumbers = true
        fiatCurrencyFormat.maximumFractionDigits = fiatCurrency.commonUnit.decimals
        fiatCurrencyFormat.minimumFractionDigits = fiatCurrency.commonUnit.decimals
        fiatCurrencyFormat.minimumIntegerDigits = 1
        fiatCurrencyFormat.maximumIntegerDigits = 12
        fiatCurrencyFormat.usesGroupingSeparator = false
        
        let fiatCurrencyAmount = NSDecimalNumber(integerLiteral: abs(amount))
            .dividing(by: NSDecimalNumber(floatLiteral: fiatCurrency.rate))
        
        let formattedAmount = fiatCurrencyFormat.string(from: fiatCurrencyAmount) ?? ""
        
        if(fiatCurrency.symbolIsLeft) {
            return "\(fiatCurrency.symbol) \(formattedAmount)"
        } else {
            return "\(formattedAmount) \(fiatCurrency.symbol)"
        }
        
    }
    
}
