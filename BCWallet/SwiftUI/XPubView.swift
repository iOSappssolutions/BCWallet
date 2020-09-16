//
//  XPubView.swift
//  BCWallet
//
//  Created by Miroslav Djukic on 20/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import SwiftUI
import BCWalletModel

struct XPubView: View {
    
    @ObservedObject var xPubViewModel: XPubViewModel
    @State var xPub: String = "xpub6CfLQa8fLgtouvLxrb8EtvjbXfoC1yqzH6YbTJw4dP7srt523AhcMV8Uh4K3TWSHz9oDWmn9MuJogzdGU3ncxkBsAC9wFBLmFrWT9Ek81kQ"
    @State var selectedTx: TransactionViewModel? = nil
    
    var body: some View {
        VStack {
            HeaderXPubView(xPub: $xPub,
                           xPubViewModel: xPubViewModel)
            .padding()
            
            List(self.xPubViewModel.transactions, id: \.transactionID) { transaction in
                Button(action: {
                    self.selectedTx = transaction
                }) {
                    TransactionRow(transaction: transaction)
                        .padding([.top, .bottom])
                }
            }
            
            Spacer()
        }
        .loading(isLoading: $xPubViewModel.isLoading)
        .alert(item: $xPubViewModel.alertMessage) { message in
            Alert(title: Text(message.message), dismissButton: .cancel())
        }
        .onAppear() {
            self.xPubViewModel.fetchWalletData(xPub: self.xPub)
        }
        .sheet(item: $selectedTx, onDismiss: {
            self.selectedTx = nil
        }) { _ in
            TransactionDetails(transaction: self.$selectedTx)
        }
           
        
    }
}

