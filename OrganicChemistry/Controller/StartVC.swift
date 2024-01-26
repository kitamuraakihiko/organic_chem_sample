//
//  StartVC.swift
//  OrganicChemistry
//
//  Created by 北村昌彦 on 2022/01/02.
//

import UIKit

class StartVC: UIViewController {
    
    @IBOutlet weak var netWorkErrorLabel: UILabel! {
        willSet {
            newValue.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        NetWorkChecker.shared.delegate = self
        
        if NetWorkChecker.shared.isOnline() {
            netWorkSatisfied()
        } else {
            netWorkErrorLabel.isHidden = false
        }
    }
}

extension StartVC: NetWorkCheckerDelegate {
    func netWorkSatisfied() {
        NetWorkChecker.shared.stop()
        performSegue(withIdentifier: K.Segue.StartVCtoTabBarController, sender: nil)
    }
}

