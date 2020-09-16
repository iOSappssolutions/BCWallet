//
//  TxInfoStack.swift
//  BCWallet
//
//  Created by Miroslav Djukic on 21/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import UIKit
import BCWalletModel

class TxInfoStack: UIStackView {
    
    private var transaction: TransactionViewModel?
    
    init(transaction: TransactionViewModel) {
        self.transaction = transaction
        super.init(frame: .zero)
        
        axis = .vertical
        alignment = .leading
        distribution = .fillEqually
        spacing = 16
    
        addSubviews()
        
    }
    
    private func addSubviews() {
        
       addArrangedSubview(TxInfoView(label: "Transaction ID",
                                     value: transaction?.transactionID ?? "",
                                     canUseClipboard: true))
       
       addArrangedSubview(TxInfoView(label: "Date",
                                     value: transaction?.longDate ?? ""))
        
       addArrangedSubview(TxInfoView(label: "Amount",
                                     value: transaction?.btcAmountText ?? ""))
        
       addArrangedSubview(TxInfoView(label: "Value",
                                     value: transaction?.fiatCurrencyAmountText ?? ""))
        
       addArrangedSubview(TxInfoView(label: "Fee",
                                     value: transaction?.fee ?? ""))
        
       addArrangedSubview(TxInfoView(label: transaction?.addressInfoText ?? "",
                                     value: transaction?.displayAddress ?? "",
                                     canUseClipboard: true))
       
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
