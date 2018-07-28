//
//  AppDelegate.swift
//  BuildingMaintenance
//
//  Created by Banerjee, Subhodip on 26/07/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit
import ApiAI
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let configuration = AIDefaultConfiguration()
        configuration.clientAccessToken = "51074fcd4dd0461c9e65c8abc99fe24d"
        let apiai = ApiAI.shared()
        apiai?.configuration = configuration
        
        IQKeyboardManager.shared.enable = true
        UIApplication.shared.statusBarStyle = .lightContent
        return true
    }

}

