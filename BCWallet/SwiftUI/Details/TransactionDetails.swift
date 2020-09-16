//
//  TransactionDetails.swift
//  BCWallet
//
//  Created by Miroslav Djukic on 21/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import SwiftUI
import BCWalletModel

struct TransactionDetails: View {
    
    @Binding var transaction: TransactionViewModel?
    
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    Text(transaction?.btcAmountText ?? "")
                    .fontWeight(.bold)
                    .font(.title)
                    
                    Spacer()
                    
                    Button(action: {
                        self.transaction = nil
                    }) {
                        Image(systemName: "xmark.circle")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 35, height: 35)
                        .foregroundColor(Color("mainColor"))
                    }
                }
                .padding(.top)
                .padding()
                
                HStack {
                    Text(transaction?.txStatusText ?? "")
                        .foregroundColor(Color("mainColor"))
                        .padding([.top, .bottom], 8)
                        .padding([.leading, .trailing])
                        .background(Color("mainColor").opacity(0.3))
                        .cornerRadius(5)
                    
                    Spacer()
                }
                .padding()
                
                TxPropertyContainer(label: "Transaction ID",
                               textValue: transaction?.transactionID ?? "",
                               canUseClipboard: true)
                
                TxPropertyContainer(label: "Date",
                               textValue: transaction?.longDate ?? "")
                
                TxPropertyContainer(label: "Amount",
                               textValue: transaction?.btcAmountText ?? "")
                
                TxPropertyContainer(label: "Value",
                                    textValue: transaction?.fiatCurrencyAmountText ?? "")
                
                TxPropertyContainer(label: "Fee",
                               textValue: transaction?.fee ?? "")
                
                TxPropertyContainer(label: transaction?.addressInfoText ?? "",
                               textValue: transaction?.displayAddress ?? "",
                               canUseClipboard: true)
                
                Spacer()
            }
        }
    }
}
