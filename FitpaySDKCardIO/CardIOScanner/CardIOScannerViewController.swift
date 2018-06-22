//
//  CardIOScannerViewController.swift
//  FitpaySDKCardIO
//
//  Created by Anton Popovichenko on 31.05.17.
//  Copyright © 2017 FitPay Inc. All rights reserved.
//

import UIKit
import FitpaySDK
import CardIO

@objc open class CardIOScannerViewController: CardIOPaymentViewController, IFitpayCardScanner {
    
    public weak var scanDelegate: FitpayCardScannerDelegate? {
        get {
            return delegateAdapter.fitpayCardScannerDelegate
        }
        set {
            delegateAdapter.fitpayCardScannerDelegate = newValue
        }
    }
    
    lazy var delegateAdapter: CardIODelegate2FitpayScannerDelegate = { [weak self] () -> CardIODelegate2FitpayScannerDelegate in
        let delegate = CardIODelegate2FitpayScannerDelegate()
        self?.paymentDelegate = delegate
        return delegate
    }()
    
    public init() {
        super.init(paymentDelegate: CardIODelegate2FitpayScannerDelegate(), scanningEnabled: true)
        self.hideCardIOLogo = true
        self.disableManualEntryButtons = true
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.hideCardIOLogo = true
        self.disableManualEntryButtons = true
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.hideCardIOLogo = true
        self.disableManualEntryButtons = true
    }
}

class CardIODelegate2FitpayScannerDelegate: NSObject, CardIOPaymentViewControllerDelegate {
    weak var fitpayCardScannerDelegate: FitpayCardScannerDelegate?
    
    override init() {
        super.init()
    }
    
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        if let scanDelegate = self.fitpayCardScannerDelegate {
            scanDelegate.canceled()
        }
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        if let scanDelegate = self.fitpayCardScannerDelegate {
            let card = ScannedCardInfo()
            card.cardNumber = cardInfo.cardNumber
            card.cvv = cardInfo.cvv
            card.expiryYear = cardInfo.expiryYear
            card.expiryMonth = cardInfo.expiryMonth

            scanDelegate.scanned(card: card, error: nil)
        }        
    }
}
