//
//  TableHeaderView.swift
//  BCWallet
//
//  Created by Miroslav Djukic on 21/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import UIKit
import BCWalletModel

class TableHeaderView: UIView {
    
    weak var xPubViewModel: XPubViewModel?
    var hierarchyNotReady = true

    private var xPubTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "xPub"
        field.text = "xpub6CfLQa8fLgtouvLxrb8EtvjbXfoC1yqzH6YbTJw4dP7srt523AhcMV8Uh4K3TWSHz9oDWmn9MuJogzdGU3ncxkBsAC9wFBLmFrWT9Ek81kQ"
        field.backgroundColor = .white
        field.textColor = .black
        field.clearButtonMode = .whileEditing
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        
        return field
    }()
    
    private var getWalletButton: UIButton = {
        let button = UIButton()
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5.0
        
        return button
    }()
    
     var fiatBalanceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        
        return label
    }()
    
    var balanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        
        return label
    }()
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()

        guard hierarchyNotReady else {
        return
        }
        backgroundColor = .white
        constructHierarchy()
        activateConstraints()

        getWalletButton.addTarget(self,
                             action: #selector(getWalletData),
                             for: .touchUpInside)
        
        hierarchyNotReady = false
        
        getWalletData()
    }
    
    func constructHierarchy() {
        addSubview(xPubTextField)
        addSubview(getWalletButton)
        addSubview(balanceLabel)
        addSubview(fiatBalanceLabel)
    }

    func activateConstraints() {
        xPubTextField.translatesAutoresizingMaskIntoConstraints = false
        getWalletButton.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        fiatBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let xPubTextFieldLeading = xPubTextField.leadingAnchor
            .constraint(equalTo: leadingAnchor, constant: 16)
        
        let xPubTextFieldTop = xPubTextField.topAnchor
            .constraint(equalTo: topAnchor, constant: 16)
        
        let xPubTextFieldHeight = xPubTextField.heightAnchor
            .constraint(equalToConstant: 40)
        
        let getWalletButtonLeading = getWalletButton.leadingAnchor
            .constraint(equalTo: xPubTextField.trailingAnchor, constant: 16)
        
        let getWalletButtonTrailing = getWalletButton.trailingAnchor
            .constraint(equalTo: self.trailingAnchor, constant: -16)
        
        let getWalletButtonTop = getWalletButton.topAnchor
            .constraint(equalTo: topAnchor, constant: 16)
        
        let getWalletHeight = getWalletButton.heightAnchor
            .constraint(equalToConstant: 40)
        
        let getWalletWidth = getWalletButton.widthAnchor
            .constraint(equalToConstant: 60)
        
        let fiatBalanceLabelLeading = fiatBalanceLabel.leadingAnchor
            .constraint(equalTo: self.leadingAnchor, constant: 16)
        
        let fiatBalanceLabelTop = fiatBalanceLabel.topAnchor
            .constraint(equalTo: xPubTextField.bottomAnchor, constant: 16)
        
        let fiatBalanceLabelBottom = fiatBalanceLabel.bottomAnchor
            .constraint(equalTo: self.bottomAnchor, constant: -16)
        
        let balanceLabelLeading = balanceLabel.leadingAnchor
            .constraint(equalTo: fiatBalanceLabel.trailingAnchor, constant: 16)
        
        let balanceLabelY = balanceLabel.centerYAnchor
            .constraint(equalTo: fiatBalanceLabel.centerYAnchor)
    
        
        NSLayoutConstraint.activate([xPubTextFieldLeading,
                                     xPubTextFieldTop,
                                     xPubTextFieldHeight,
                                     getWalletButtonLeading,
                                     getWalletButtonTrailing,
                                     getWalletButtonTop,
                                     getWalletHeight,
                                     getWalletWidth,
                                     fiatBalanceLabelLeading,
                                     fiatBalanceLabelTop,
                                     fiatBalanceLabelBottom,
                                     balanceLabelLeading,
                                     balanceLabelY
                                     ])
    }

}

extension TableHeaderView {
    
    @objc
    func getWalletData() {
        guard let xPubViewModel = xPubViewModel, let xPub = xPubTextField.text else { return }
        
        xPubViewModel.fetchWalletData(xPub: xPub)
    }
}
