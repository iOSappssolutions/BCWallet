//
//  RootVCRepresentable.swift
//  BCWallet
//
//  Created by Miroslav Djukic on 21/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import SwiftUI
import BCWalletModel

struct RootVCRepresentable: UIViewControllerRepresentable {
    
    var xPubViewModel: XPubViewModel
    typealias UIViewControllerType = WalletViewController
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<RootVCRepresentable>) -> UIViewControllerType {
        
        let walletList = WalletViewController(xPubViewModel: xPubViewModel)
        
        return walletList
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<RootVCRepresentable>) {
        
    }


}
