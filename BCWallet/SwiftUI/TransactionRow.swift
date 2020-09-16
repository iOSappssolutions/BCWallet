//
//  TransactionRow.swift
//  BCWallet
//
//  Created by Miroslav Djukic on 21/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import SwiftUI
import BCWalletModel

struct TransactionRow: View {
    
    var transaction: TransactionViewModel
    
    var body: some View {
        HStack {
            Image(systemName: transaction.direction == .outgoing
                ? "arrow.up.right.circle"
                : "arrow.down.left.circle")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(Color(.orange))
                .frame(width: 30, height: 30)
            
            VStack(alignment: .leading) {
                Text(transaction.shortDescriptionText)
                
                Text(transaction.shortDate)
            }
            
            Spacer()
            
            VStack {
                HStack {
                    Spacer()
                    
                    Text(transaction.fiatCurrencyAmountText)
                    .fontWeight(.semibold)
                }
                
                HStack {
                    Spacer()
                    
                    Text(transaction.btcAmountText)
                    .fontWeight(.light)
                    .font(.caption)
                }
            }
            
        }
    }
}
