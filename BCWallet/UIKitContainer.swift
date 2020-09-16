//
//  ContentView.swift
//  BCWalletTest
//
//  Created by Miroslav Djukic on 20/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import SwiftUI
import BCWalletModel

struct UIKitContainer: View {
    
    @ObservedObject var xPubViewModel: XPubViewModel
    
    var body: some View {
        RootVCRepresentable(xPubViewModel: xPubViewModel)
            .background(Color(.white))
    }
}

