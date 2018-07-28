//
//  DecisionMakingViewController.swift
//  BuildingMaintenance
//
//  Created by Banerjee, Subhodip on 26/07/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit

class DecisionMakingViewController: UIViewController {
    
    var problemStatement = ""
    var deviceName = ""
    var model = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func navigationButtonAction(_ sender: UIButton) {
        initializeARViewController()
    }
    
    func initializeARViewController() {
        guard let chatVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ARViewController") as? ARViewController else { return }
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    @IBAction func assistanceButtonAction(_ sender: UIButton) {
        initializeChatViewController(problemLabel: problemStatement)
    }
    
    func initializeChatViewController(problemLabel: String) {
        guard let chatVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController else { return }
        chatVC.problemStatement = "I can detect a problem with \(problemLabel), with the device name \(deviceName) and model number \(model)."
        navigationController?.pushViewController(chatVC, animated: true)
    }
}
