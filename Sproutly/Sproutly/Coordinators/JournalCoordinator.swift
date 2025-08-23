//
//  JournalCoordinator.swift
//  Sproutly
//
//  Created by Deniz Turan Çağlarca on 12.08.2025.
//

import UIKit

final class JournalCoordinator: NavigationCoordinator {
    var childCoordinators: [Coordinator] = []
    private let dependencies: AppDependencies
    var navigationController: UINavigationController
    
    var handleLogout: (() -> Void)?
    
    init(navigationController: UINavigationController, dependencies: AppDependencies) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }
    
    func start() {
        let repository = JournalRepository(coreDataStack: dependencies.coreDataStack)
        let journalVC = JournalViewController(repository: repository)
        navigationController.setViewControllers([journalVC], animated: false)
    }
}
