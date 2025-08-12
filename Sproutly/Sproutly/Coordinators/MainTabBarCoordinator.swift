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
        profileCoordinator.start()
        addChild(profileCoordinator)
        
        tabBarController.viewControllers = [journalNav, profileNav]
    }
}
