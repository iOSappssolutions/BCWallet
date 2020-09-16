//
//  UIViewController+Alerts.swift
//  BCWallet
//
//  Created by Miroslav Djukic on 21/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import UIKit

extension UIViewController {

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    class func displaySpinner() -> UIView {
        let spinnerView = UIView.init(frame: UIScreen.main.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.65)
        var ai: UIActivityIndicatorView
    
        ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            
            guard let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
            keyWindow.addSubview(spinnerView)
            keyWindow.bringSubviewToFront(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
