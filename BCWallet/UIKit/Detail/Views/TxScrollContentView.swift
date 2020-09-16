//
//  TxScrollView.swift
//  BCWallet
//
//  Created by Miroslav Djukic on 21/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import UIKit
import BCWalletModel

class TxScrollContentView: UIView {

    private var transaction: TransactionViewModel
    var dismissCallback: (()->())?
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
        label.textColor = .blue
        label.textAlignment = .center
        
        return label
    }()
    
    private let txAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 28)
        
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.addTarget(self,
            action: #selector(dismissAction),
            for: .touchUpInside)
        
        return button
    }()
    
    lazy private var infoStack = TxInfoStack(transaction: transaction)
    
    init(transaction: TransactionViewModel) {
        self.transaction = transaction
        super.init(frame: .zero)
        self.statusLabel.text = transaction.txStatusText
        self.txAmountLabel.text = transaction.btcAmountText
        self.backgroundColor = .white
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(txAmountLabel)
        addSubview(closeButton)
        addSubview(statusLabel)
        addSubview(infoStack)
    }
    
    private func addConstraints() {
        txAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        
        let txAmountLeading = txAmountLabel.leadingAnchor
            .constraint(equalTo: leadingAnchor, constant: 16)
        
        let txAmountTop = txAmountLabel.topAnchor
            .constraint(equalTo: topAnchor, constant: 16)
        
        let closeButtonTop = closeButton.topAnchor
            .constraint(equalTo: topAnchor, constant: 16)
        
        let closeButtonTrailing = closeButton.trailingAnchor
            .constraint(equalTo: trailingAnchor, constant: -16)
        
        let closeButtonLeading = closeButton.leadingAnchor
            .constraint(equalTo: txAmountLabel.trailingAnchor, constant: 16)
        
        let closeButtonHeight = closeButton.heightAnchor
            .constraint(equalToConstant: 35)
        
        let closeButtonWidth = closeButton.widthAnchor
            .constraint(equalToConstant: 35)
        
        let statusLeading = statusLabel.leadingAnchor
            .constraint(equalTo: leadingAnchor, constant: 16)
        
        let statusTop = statusLabel.topAnchor
            .constraint(equalTo: txAmountLabel.bottomAnchor, constant: 16)
        
        let statusWidth = statusLabel.widthAnchor
            .constraint(equalToConstant: 100)
        
        let infoStackTop = infoStack.topAnchor
            .constraint(equalTo: statusLabel.bottomAnchor, constant: 16)
        
        let infoStackLeading = infoStack.leadingAnchor
            .constraint(equalTo: self.leadingAnchor, constant: 16)
        
        let infoStackTrailing = infoStack.trailingAnchor
            .constraint(equalTo: self.trailingAnchor, constant: -16)
        
        let infoStackBottom = infoStack.bottomAnchor
            .constraint(equalTo: self.bottomAnchor, constant: -16)
        
        NSLayoutConstraint.activate([txAmountLeading,
            txAmountTop,
            closeButtonTop,
            closeButtonTrailing,
            closeButtonLeading,
            closeButtonHeight,
            closeButtonWidth,
            statusLeading,
            statusTop,
            statusWidth,
            infoStackTop,
            infoStackLeading,
            infoStackTrailing,
            infoStackBottom,
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TxScrollContentView {
    
    @objc
    func dismissAction() {
        guard let dismiss = dismissCallback else { return }
        dismiss()
    }
    
}
