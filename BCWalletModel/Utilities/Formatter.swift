//
//  Formatter.swift
//  BCWalletModel
//
//  Created by Miroslav Djukic on 21/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

let shortDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM YYYY"
    #if test
        formatter.timeZone = TimeZone(abbreviation: "CET")
    #else
        formatter.timeZone = TimeZone.current
    #endif
    
    return formatter
}()

let longDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd, YYYY @ hh:mm a"
    #if test
        formatter.timeZone = TimeZone(abbreviation: "CET")
    #else
        formatter.timeZone = TimeZone.current
    #endif
      
    return formatter
}()

