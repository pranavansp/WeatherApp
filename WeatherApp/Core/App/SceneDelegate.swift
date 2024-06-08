//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-08.
//

import UIKit

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    private var coordinator: AppLifecycleCoordinator?
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let appLifecycleCoordinator = AppLifecycleCoordinator(window: window)
        self.coordinator = appLifecycleCoordinator
        self.window = window
        
        appLifecycleCoordinator.startLanding()
        
        window.makeKeyAndVisible()
    }
}
