//
//  CoppiedToClipboardView.swift
//  BCWallet
//
//  Created by Miroslav Djukic on 21/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import SwiftUI

struct CoppiedToClipboardView: View {

    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                Spacer()
                
                Text("Coppied to clipboard!")
                .foregroundColor(Color(.white))
                
                Spacer()
            }
            Spacer()
        }
        .background(Color(.systemGreen))
    }

}
