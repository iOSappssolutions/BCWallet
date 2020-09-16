//
//  TxInfoView.swift
//  BCWallet
//
//  Created by Miroslav Djukic on 21/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import UIKit

class TxInfoView: UIStackView {
    
    private var copyToClipboardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "doc.on.clipboard"), for: .normal)
        button.addTarget(self,
                         action: #selector(copyToClipBoard),
                         for: .touchUpInside)
        
        return button
    }()
    
     var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()
    
    var value: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView =
        UIStackView(arrangedSubviews: [label, value])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 0
        
        return stackView
    }()
    
    private var canUseClipboard: Bool
    
    init(label: String, value: String, canUseClipboard:Bool = false) {
        self.label.text = label
        self.value.text = value
        self.canUseClipboard = canUseClipboard
        
        super.init(frame: .zero)
        
        self.constructHierarchy()
        self.activateConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constructHierarchy() {
        addSubview(labelStackView)
        
        if canUseClipboard {
            addSubview(copyToClipboardButton)
        }
    }

    func activateConstraints() {
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let labelStackViewLeading = labelStackView.leadingAnchor
            .constraint(equalTo: leadingAnchor, constant: 0)
        
        let labelStackViewTop = labelStackView.topAnchor
            .constraint(equalTo: topAnchor, constant: 0)
        
        let labelStackViewBottom = labelStackView.bottomAnchor
            .constraint(equalTo: bottomAnchor, constant: 0)
        
        var labelStackViewTrailing: NSLayoutConstraint
        
        if canUseClipboard {
            copyToClipboardButton.translatesAutoresizingMaskIntoConstraints = false
            labelStackViewTrailing = labelStackView.trailingAnchor
                .constraint(equalTo: copyToClipboardButton.leadingAnchor, constant: -16)
            
            let clipboardTrailing = copyToClipboardButton.trailingAnchor
                .constraint(equalTo: self.trailingAnchor, constant: 0)
            
            let clipboardCenter = copyToClipboardButton.centerYAnchor
                .constraint(equalTo: self.centerYAnchor)
            
            NSLayoutConstraint.activate([clipboardTrailing,
                                        clipboardCenter])
            
        } else {
            labelStackViewTrailing = labelStackView.trailingAnchor
            .constraint(equalTo: self.trailingAnchor, constant: 0)
        }
        

        
        NSLayoutConstraint.activate([labelStackViewLeading,
                                     labelStackViewTop,
                                     labelStackViewBottom,
                                     labelStackViewTrailing])
    }
}

extension TxInfoView {
    
    @objc
    func copyToClipBoard() {
        
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = self.value.text
        
        let cpClipboardView = addCoppiedToClipboard()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            cpClipboardView.removeFromSuperview()
        }
    }
    
    func addCoppiedToClipboard() -> UIView {
        
        let copiedToClipboardLabel = UILabel()
        copiedToClipboardLabel.text = "Copied to clipboard!"
        copiedToClipboardLabel.textColor = .white
        copiedToClipboardLabel.backgroundColor = .green
        copiedToClipboardLabel.translatesAutoresizingMaskIntoConstraints = false
        copiedToClipboardLabel.textAlignment = .center
        
        self.addSubview(copiedToClipboardLabel)
        
        let copiedToClipboardLeading = copiedToClipboardLabel.leadingAnchor
            .constraint(equalTo: self.leadingAnchor)
        
        let copiedToClipboardTrailing = copiedToClipboardLabel.trailingAnchor
            .constraint(equalTo: self.trailingAnchor)
        
        let copiedToClipboardTop = copiedToClipboardLabel.topAnchor
            .constraint(equalTo: self.topAnchor)
        
        let copiedToClipboardBottom = copiedToClipboardLabel.bottomAnchor
            .constraint(equalTo: self.bottomAnchor)
        
        UIView.animate(withDuration: 0.3) {
            NSLayoutConstraint.activate([copiedToClipboardLeading,
            copiedToClipboardTrailing,
            copiedToClipboardTop,
            copiedToClipboardBottom])
            self.layoutIfNeeded()
        }
        
        return copiedToClipboardLabel
    }
    
    
    
}
