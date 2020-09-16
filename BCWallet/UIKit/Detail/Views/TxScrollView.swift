//
//  TxScrollView.swift
//  BCWallet
//
//  Created by Miroslav Djukic on 21/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import UIKit
import BCWalletModel

class TxScrollView: UIScrollView {

    private var transaction: TransactionViewModel
    var dismissCallback: (()->())?
    
    lazy private var scrollContainerView = TxScrollContentView(transaction: transaction)
    
    init(transaction: TransactionViewModel) {
        self.transaction = transaction
        super.init(frame: .zero)
        scrollContainerView.dismissCallback = { [weak self] in
            guard let dismiss = self?.dismissCallback else { return }
            dismiss()
        }
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(scrollContainerView)

    }
    
    private func addConstraints() {
        scrollContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        let scrollContainerViewLeading = scrollContainerView.leadingAnchor
            .constraint(equalTo: leadingAnchor)
        
        let scrollContainerViewTop = scrollContainerView.topAnchor
            .constraint(equalTo: topAnchor)
        
        let scrollContainerViewBottom = scrollContainerView.bottomAnchor
            .constraint(equalTo: bottomAnchor)
        
        let scrollContainerViewTrailing = scrollContainerView.trailingAnchor
                   .constraint(equalTo: trailingAnchor)
        
        let scrollContainerViewWidth = scrollContainerView.widthAnchor
            .constraint(equalTo: widthAnchor)
        
        
        NSLayoutConstraint.activate([
            scrollContainerViewLeading,
            scrollContainerViewTop,
            scrollContainerViewBottom,
            scrollContainerViewTrailing,
            scrollContainerViewWidth
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

