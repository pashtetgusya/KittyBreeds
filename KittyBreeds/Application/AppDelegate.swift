//
//  AppDelegate.swift
//  KittyBreeds
//
//  Created by Pavel Yarovoi on 23.08.2022.
//

import UIKit
import Kingfisher

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let cache = ImageCache.default
        cache.memoryStorage.config.totalCostLimit = 1024 * 1024 * 10
        cache.memoryStorage.config.cleanInterval = 30
        cache.diskStorage.config.sizeLimit = 1024 * 1024 * 100
        
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
        
        return true
    }

}

