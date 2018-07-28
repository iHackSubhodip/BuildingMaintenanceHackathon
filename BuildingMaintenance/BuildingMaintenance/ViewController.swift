//
//  ViewController.swift
//  BuildingMaintenance
//
//  Created by Banerjee, Subhodip on 26/07/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//



import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func helplineChatButton(_ sender: UIButton) {
        initialiseChatViewController()
    }
    
    private func initialiseChatViewController() {
        guard let chatVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FAQViewController") as? FAQViewController else { return }
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    
}

