//
//  ProfileCoordinator.swift
//  Sproutly
//
//  Created by Deniz Turan Çağlarca on 12.08.2025.
//

import UIKit

final class ProfileCoordinator: NavigationCoordinator {
    private let dependencies: AppDependencies

    init(navigationController: UINavigationController, dependencies: AppDependencies) {
        self.dependencies = dependencies
        super.init(navigationController: navigationController)
    }

    override func start() {
        let vc = UIViewController() // Replace with ProfileViewController
        vc.view.backgroundColor = .white
        vc.title = "Profile"
        navigationController.setViewControllers([vc], animated: false)
    }
}
