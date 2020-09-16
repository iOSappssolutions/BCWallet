//
//  TxPropertyContainer.swift
//  BCWallet
//
//  Created by Miroslav Djukic on 21/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import SwiftUI

struct TxPropertyContainer: View {
    
    var label: String
    var textValue: String
    var canUseClipboard: Bool = false
    
    var body: some View {
        return TxPropertyInfo(label: label,
                              textValue: textValue,
                              canUseClipboard: canUseClipboard)
    }
}
