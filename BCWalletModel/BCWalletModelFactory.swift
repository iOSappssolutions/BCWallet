//
//  BCWalletModelFactory.swift
//  BCWalletModel
//
//  Created by Miroslav Djukic on 20/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import SwiftUI

public class BCWalletModelFactory {
    
    public init() {}
    
    static func makeXPubAPI() -> XPubAPI {
        #if test
            return FakeXPubAPI()
        #else
            return BCWalletXPubAPI()
        #endif
    }
    
    public static func makeXPubViewModel() -> XPubViewModel {
        return XPubViewModel(xPubAPI: makeXPubAPI())
    }
        
}


