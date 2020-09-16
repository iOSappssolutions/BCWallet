//
//  TransactionCell.swift
//  BCWallet
//
//  Created by Miroslav Djukic on 21/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import UIKit
import BCWalletModel

class TransactionCell: UITableViewCell {

    private var transaction: TransactionViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        addConstraints()
        backgroundColor = .white
    }
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.black
        
        return label
    }()
    
    private let fiatAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = UIColor.black
        
        return label
    }()
    
    private let shortDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor.black
        
        return label
    }()
    
    private let shortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor.black
        
        return label
    }()
    
    private var lineViewSeparator: UIView = {
        let line = UIView()
        line.backgroundColor = .gray
        line.translatesAutoresizingMaskIntoConstraints = false
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        return line
    }()
    
    lazy var descStackView: UIStackView = {
      let stackView =
      UIStackView(arrangedSubviews: [shortDescriptionLabel, shortDateLabel])
      stackView.axis = .vertical
      stackView.distribution = .fillEqually
      stackView.alignment = .leading
      stackView.spacing = 8
        
      return stackView
    }()
    
    lazy var amountStackView: UIStackView = {
      let stackView =
      UIStackView(arrangedSubviews: [fiatAmountLabel, amountLabel])
      stackView.axis = .vertical
      stackView.distribution = .fillEqually
      stackView.alignment = .trailing
      stackView.spacing = 8
        
      return stackView
    }()
    
    private let txImageView = UIImageView()
    
    func setCell(transaction: TransactionViewModel) {
        self.transaction = transaction
        if transaction.direction == .outgoing {
            self.txImageView.image = UIImage(systemName: "arrow.up.right.circle", withConfiguration: .none)
        } else {
            self.txImageView.image = UIImage(systemName: "arrow.down.left.circle", withConfiguration: .none)
        }
        self.shortDateLabel.text = transaction.shortDate
        self.shortDescriptionLabel.text = transaction.shortDescriptionText
        self.amountLabel.text = transaction.btcAmountText
        self.fiatAmountLabel.text = transaction.fiatCurrencyAmountText
    
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(txImageView)
        addSubview(descStackView)
        addSubview(amountStackView)
    }
    
    private func addConstraints() {
        
        txImageView.translatesAutoresizingMaskIntoConstraints = false
        descStackView.translatesAutoresizingMaskIntoConstraints = false
        amountStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageLeading = txImageView.leadingAnchor
            .constraint(equalTo: leadingAnchor, constant: 16)
        
        let imageWidth = txImageView.widthAnchor
            .constraint(equalToConstant: 30)
        
        let imageHeight = txImageView.heightAnchor
        .constraint(equalToConstant: 30)
        
        let imageCenter = txImageView.centerYAnchor
            .constraint(equalTo: self.centerYAnchor)
        
        let labelStackLeading = descStackView.leadingAnchor
            .constraint(equalTo: txImageView.trailingAnchor, constant: 16)
        
        let labelStackTop = descStackView.topAnchor
            .constraint(greaterThanOrEqualTo: self.topAnchor)
        
        let labelStackBottom = descStackView.bottomAnchor
            .constraint(lessThanOrEqualTo: self.bottomAnchor)
        
        let labelStackCenter = descStackView.centerYAnchor
            .constraint(equalTo: self.centerYAnchor)
        
        let amountLabelTrailing = amountStackView.trailingAnchor
            .constraint(equalTo: self.trailingAnchor, constant: -16)
        
        let amountLabelY = amountStackView.centerYAnchor
            .constraint(equalTo: self.centerYAnchor)
        
        let amoungLabelLeading = amountStackView.leadingAnchor
            .constraint(equalTo: descStackView.trailingAnchor, constant: 16)
        
        NSLayoutConstraint.activate([imageLeading,
                                     imageWidth,
                                     imageHeight,
                                     imageCenter,
                                     labelStackLeading,
                                     labelStackTop,
                                     labelStackBottom,
                                     labelStackCenter,
                                     amountLabelTrailing,
                                     amountLabelY,
                                     amoungLabelLeading])
    }

}
