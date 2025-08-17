//
//  MainTabBarCoordinator.swift
//  Sproutly
//
//  Created by Deniz Turan Çağlarca on 12.08.2025.
//


import UIKit

final class MainTabBarCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let tabBarController = UITabBarController()
    private let dependencies: AppDependencies
    
    var onLogout: (() -> Void)?
    
    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }
    
    func start() {
        let journalNav = UINavigationController()
        let journalCoordinator = JournalCoordinator(
            navigationController: journalNav,
            dependencies: dependencies
        )
        journalCoordinator.start()
        addChild(journalCoordinator)
        
        let profileNav = UINavigationController()
        let profileCoordinator = ProfileCoordinator(
            navigationController: profileNav,
            dependencies: dependencies
        )
        
        profileCoordinator.handleLogout = { [weak self] in
            self?.handleLogout()
        }
        
        profileCoordinator.start()
        addChild(profileCoordinator)
        
        journalNav.tabBarItem = UITabBarItem(title: Strings.Journal.journalTitle, image: .add, tag: 1)
        profileNav.tabBarItem = UITabBarItem(title: Strings.Profile.profileTitle, image: .remove, tag: 2)
        
        tabBarController.setViewControllers([journalNav, profileNav], animated: false)
        tabBarController.tabBar.tintColor = .green
    }
    
    private func handleLogout() {
        onLogout?()
    }
}
