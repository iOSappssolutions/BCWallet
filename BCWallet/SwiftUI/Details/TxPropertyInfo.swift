//
//  TxPropertyInfo.swift
//  BCWallet
//
//  Created by Miroslav Djukic on 21/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import SwiftUI

struct TxPropertyInfo: View {
    
    var label: String
    var textValue: String
    var canUseClipboard: Bool
    @State var coppiedToClipboard: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(label)
                        .fontWeight(.light)
                        
                        Text(textValue)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                    }
                    
                    Spacer()
                    
                    if(canUseClipboard) {
                        Button(action: {
                            let pasteBoard = UIPasteboard.general
                            pasteBoard.string = self.textValue
                            self.coppiedToClipboard = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.coppiedToClipboard = false
                            }
                        }) {
                            Image(systemName: "doc.on.clipboard")
                            .renderingMode(.template)
                            .foregroundColor(Color("mainColor"))
                            .padding()
                        }
                    }
                }
                .padding()
                Divider()
            }
            
            CoppiedToClipboardView()
                .opacity(coppiedToClipboard ? 1 : 0)
                .animation(.easeInOut)
            
        }
    }
}
