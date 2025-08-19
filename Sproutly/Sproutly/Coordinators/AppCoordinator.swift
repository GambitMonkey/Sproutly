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
        
        // Jump to login for UI Test
        if CommandLine.arguments.contains("-skipOnboarding") {
            showLogin()
            return
        }
        
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
            self?.showLogin()
        }
        
        navigationController.pushViewController(onboardingVc, animated: false)
    }
    
    private func showLogin() {
        let loginCoordinator = LoginCoordinator(dependencies: dependencies, navigationController: navigationController)
        
        loginCoordinator.onFinish = { [weak self, weak loginCoordinator] in
            if let loginCoordinator {
                self?.removeChild(loginCoordinator)
            }
            self?.showMainTabBar()
        }
        
        addChild(loginCoordinator)
        loginCoordinator.start()
    }

    
    private func showMainTabBar() {
        let mainTabBarCoordinator = MainTabBarCoordinator(dependencies: dependencies)
        
        mainTabBarCoordinator.onLogout = { [weak self, weak mainTabBarCoordinator] in
            if let mainTabBarCoordinator {
                self?.removeChild(mainTabBarCoordinator)
            }
//            self?.navigationController.popViewController(animated: true)
            self?.showLogin()
        }
        
        addChild(mainTabBarCoordinator)
        mainTabBarCoordinator.start()
        navigationController.pushViewController(mainTabBarCoordinator.tabBarController, animated: true)
    }
}
