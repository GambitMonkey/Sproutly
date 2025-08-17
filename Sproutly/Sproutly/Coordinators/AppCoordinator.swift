//
//  AppCoordinator.swift
//  Sproutly
//
//  Created by Deniz Turan Çağlarca on 12.08.2025.
//


import UIKit

final class AppCoordinator: NavigationCoordinator {
    var navigationController: UINavigationController
    internal var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    private let dependencies: AppDependencies
    
    init(window: UIWindow, dependencies: AppDependencies, navigationController: UINavigationController) {
        self.window = window
        self.dependencies = dependencies
        self.navigationController = navigationController
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        if dependencies.userDefaults.bool(forKey: Keys.UserDefaults.hasCompletedOnboarding) {
            showMainTabBar()
        } else {
            showOnboarding()
        }
    }
    
    private func showOnboarding() {
        let onboardingVc = OnboardingViewController()
        
        onboardingVc.onFinish = { [weak self] in
            // self.dependencies.userDefaults.set(true, forKey: Keys.UserDefaults.hasCompletedOnboarding)
            self?.showMainTabBar()
        }
        
        navigationController.pushViewController(onboardingVc, animated: false)
    }
    
    private func showMainTabBar() {
        let mainTabBarCoordinator = MainTabBarCoordinator(dependencies: dependencies)
        addChild(mainTabBarCoordinator)
        mainTabBarCoordinator.onLogout = { [weak self] in
            self?.navigationController.popViewController(animated: true)
            self?.showOnboarding()
        }
        mainTabBarCoordinator.start()
        navigationController.pushViewController(mainTabBarCoordinator.tabBarController, animated: true)
    }
}
