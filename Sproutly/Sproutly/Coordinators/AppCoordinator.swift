//
//  AppCoordinator.swift
//  Sproutly
//
//  Created by Deniz Turan Çağlarca on 12.08.2025.
//


import UIKit

import UIKit

final class AppCoordinator: NavigationCoordinator {
    private let window: UIWindow
    private let dependencies: AppDependencies
    
    init(window: UIWindow, dependencies: AppDependencies) {
        self.window = window
        self.dependencies = dependencies
        super.init() // uses default UINavigationController
    }
    
    override func start() {
        if dependencies.userDefaults.bool(forKey: Keys.UserDefaults.hasCompletedOnboarding) {
            showMainTabBar()
        } else {
            showOnboarding()
        }
    }
    
    private func showOnboarding() {
        let onboardingCoordinator = OnboardingCoordinator(dependencies: dependencies)

        // 1️⃣ Retain coordinator
        addChild(onboardingCoordinator)

        onboardingCoordinator.onFinish = { [weak self, weak onboardingCoordinator] in
            guard let self = self else { return }
            self.dependencies.userDefaults.set(true, forKey: Keys.UserDefaults.hasCompletedOnboarding)
            
            if let onboardingCoordinator {
                self.removeChild(onboardingCoordinator)
            }
            
            self.showMainTabBar()
        }

        // 2️⃣ Show onboarding as root
        window.rootViewController = onboardingCoordinator.rootViewController
        window.makeKeyAndVisible()

        onboardingCoordinator.start()
    }
    
    private func showMainTabBar() {
        let tabBarCoordinator = MainTabBarCoordinator(dependencies: dependencies)
        addChild(tabBarCoordinator)
        window.rootViewController = tabBarCoordinator.tabBarController
        window.makeKeyAndVisible()
        tabBarCoordinator.start()
    }
}
