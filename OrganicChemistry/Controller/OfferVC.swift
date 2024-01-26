//
//  OfferVC.swift
//  OrganicChemistry
//
//  Created by 北村昌彦 on 2021/12/30.
//

import UIKit
import StoreKit

class OfferVC: UIViewController {
    
    var pm = PurchaseManager()
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var explainView: UITextView! {
        didSet {
            explainView.attributedText = setupExplainText(text: K.Informationtext.subscriptionExplainText)
            explainView.textColor = .white
            explainView.tintColor = .systemIndigo
            explainView.isSelectable = true
            explainView.isEditable = false
        }
    }

    @IBOutlet weak var spinner: UIActivityIndicatorView! {
        didSet {
            spinner.hidesWhenStopped = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.bool(forKey: K.Purchase.isPurchased) {
            
            var config = purchaseButton.configuration
            config?.image = UIImage(systemName: "checkmark.circle")
            config?.title = nil
            purchaseButton.configuration = config
        }
        
        pm.delegate = self
    }
    
    @IBAction func purchaseBUttonPressed(_ sender: UIButton) {
        self.isModalInPresentation = true
        spinner.startAnimating()
        pm.purchase()
        view.isUserInteractionEnabled = false
    }
}

extension OfferVC: completeTransactionDelegate {
    func cancel() {
        spinner.stopAnimating()
        
        var popUp = PopUp(viewController: self, style: .multiply)
        popUp.color = .orange
        popUp.start(completion: nil)
        
        view.isUserInteractionEnabled = true
        self.isModalInPresentation = false
    }
    
    func completeTransaction() {
        spinner.stopAnimating()
        
        let popUp = PopUp(viewController: self, style: .check)
        popUp.start(completion: {
            self.dismiss(animated: true, completion: nil)
        })
        
        view.isUserInteractionEnabled = true
        self.isModalInPresentation = false
        
    }
}

extension OfferVC {
    func setupExplainText(text: String) -> NSMutableAttributedString {
        
        let attributedString = NSMutableAttributedString(string: text)
        
        attributedString.addAttribute(.link,
                                      value: K.LinkStrings.appleEULA,
                                      range: NSString(string: text).range(of: "利用規約"))
        
        attributedString.addAttribute(.link,
                                      value: K.LinkStrings.appSuppet,
                                      range: NSString(string: text).range(of: "プライバシーポリシー"))
        
        return attributedString
    }
}
