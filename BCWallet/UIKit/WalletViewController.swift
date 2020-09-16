//
//  TableViewController.swift
//  BCWallet
//
//  Created by Miroslav Djukic on 21/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import UIKit
import Combine
import BCWalletModel

class WalletViewController: UITableViewController {
    
    private var xPubViewModel: XPubViewModel
    private var subscriptions = Set<AnyCancellable>()
    private let transactionCellID = "transactionCellID"
    private var spinner: UIView?
    
    private let headerView = TableHeaderView()
    
    private var btcBalanceText: String? {
        didSet {
            self.headerView.balanceLabel.text = btcBalanceText
        }
    }
    
    private var fiatBalanceText: String? {
        didSet {
            self.headerView.fiatBalanceLabel.text = fiatBalanceText
        }
    }
    
    private var transactions: [TransactionViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var alertMessage: String? {
        didSet{
            guard let message = alertMessage else { return }
            self.showAlert(title: "", message: message)
        }
    }
    
    private var isLoading: Bool = false {
        didSet {
            if(isLoading) {
                spinner = WalletViewController.displaySpinner()
            } else {
                guard let spinner = spinner else { return }
                WalletViewController.removeSpinner(spinner: spinner)
            }
        }
    }
    
    init(xPubViewModel: XPubViewModel) {
        self.xPubViewModel = xPubViewModel
        super.init(nibName: nil, bundle: nil)
        self.funcSetObserver()
        self.registerCells()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        view.backgroundColor = .white

    }
    
    private func funcSetObserver() {
        
        xPubViewModel.$alertMessage
        .map({ $0?.message })
        .assign(to: \.alertMessage, on: self)
        .store(in: &subscriptions)
        
        xPubViewModel.$isLoading
        .assign(to: \.isLoading, on: self)
        .store(in: &subscriptions)
        
        xPubViewModel.$transactions
        .sink { [weak self] (transactions) in
            self?.transactions = transactions
            self?.btcBalanceText = self?.xPubViewModel.walletBalanceBTCText
            self?.fiatBalanceText = self?.xPubViewModel.walletBalanceFiatText
        }
        .store(in: &subscriptions)
    }
    
    private func registerCells() {
        tableView.register(TransactionCell.self, forCellReuseIdentifier: transactionCellID)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: transactionCellID, for: indexPath)

        if let txCell = cell as? TransactionCell {
            txCell.setCell(transaction: transactions[indexPath.row])
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView.xPubViewModel = self.xPubViewModel
        return headerView
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transaction = transactions[indexPath.row]
        self.view.endEditing(true)
        let presentVC = TransactionDetailsViewController(transaction: transaction)
        self.present(presentVC, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
