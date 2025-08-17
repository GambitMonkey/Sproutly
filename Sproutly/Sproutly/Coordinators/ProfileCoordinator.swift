//
//  ProfileCoordinator.swift
//  Sproutly
//
//  Created by Deniz Turan Çağlarca on 12.08.2025.
//

import UIKit

final class ProfileCoordinator: NavigationCoordinator {
    var childCoordinators: [Coordinator] = []
    private let dependencies: AppDependencies
    var navigationController: UINavigationController
    
    var handleLogout: (() -> Void)?

    init(navigationController: UINavigationController, dependencies: AppDependencies) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }

    func start() {
        let vc = ProfileViewController()
        
        vc.onLogout = { [weak self] in
            self?.onLogout()
        }
        
        navigationController.setViewControllers([vc], animated: false)
    }
    
    func onLogout() {
        handleLogout?()
    }
}
