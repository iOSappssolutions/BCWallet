//
//  TransactionDetailsViewController.swift
//  BCWallet
//
//  Created by Miroslav Djukic on 21/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import UIKit
import BCWalletModel

class TransactionDetailsViewController: UIViewController {
    
    init(transaction: TransactionViewModel) {
        super.init(nibName: nil, bundle: nil)
        let scrollView = TxScrollView(transaction: transaction)
        scrollView.dismissCallback = { [weak self] in
            self?.dismiss(animated: true)
        }
        self.view.backgroundColor = .white
        
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let scrollViewLeading = scrollView.leadingAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        
        let scrollViewTrailing = scrollView.trailingAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        
        let scrollViewTop = scrollView.topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        
        let scrollViewBottom = scrollView.bottomAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([
            scrollViewLeading,
            scrollViewTrailing,
            scrollViewTop,
            scrollViewBottom,
        ])
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
