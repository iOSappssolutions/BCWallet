//
//  HeaderXPubView.swift
//  BCWallet
//
//  Created by Miroslav Djukic on 21/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import SwiftUI
import BCWalletModel

struct HeaderXPubView: View {
    
    @Binding var xPub: String
    @ObservedObject var xPubViewModel: XPubViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(spacing:0) {
                    TextField("xPub", text: $xPub)
                        .font(.footnote)
                    Divider()
                }
                
                VStack(spacing: 16) {
                    
                    Button(action: {
                        self.xPub = ""
                            
                    }) {
                        Text("CLEAR")
                            .frame(width: 60)
                            .font(.callout)
                            .padding([.top, .bottom], 8)
                            .padding([.leading, .trailing])
                            .foregroundColor(Color("mainColor"))
                            .background(Color(.clear))
                            .border(Color("mainColor"), width: 3)
                            .cornerRadius(5)
                    }
                    
                    Button(action: {
                        self.xPubViewModel.fetchWalletData(xPub: self.xPub)
                            
                    }) {
                        Text("GET")
                            .frame(width: 60)
                            .font(.callout)
                            .padding([.top, .bottom], 8)
                            .padding([.leading, .trailing])
                            .foregroundColor(.white)
                            .background(Color("mainColor"))
                            .cornerRadius(5)
                    }
                }
            }
            
            HStack {
                Text("Wallet Balance")
                    .fontWeight(.bold)
                    .font(.headline)
                
                Spacer()
            }
            
            HStack {
                Text(xPubViewModel.walletBalanceFiatText)
                    .fontWeight(.bold)
                    .font(.headline)
                
                Text("-")
                
                Text(xPubViewModel.walletBalanceBTCText)
                    .fontWeight(.light)
                    .font(.body)
                Spacer()
            }
        }
    }
}

