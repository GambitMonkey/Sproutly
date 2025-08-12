//
//  JournalCoordinator.swift
//  Sproutly
//
//  Created by Deniz Turan Çağlarca on 12.08.2025.
//

import UIKit

final class JournalCoordinator: NavigationCoordinator {
    private let dependencies: AppDependencies
    
    init(navigationController: UINavigationController, dependencies: AppDependencies) {
        self.dependencies = dependencies
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        let vc = UIViewController() // Replace with JournalViewController
        vc.view.backgroundColor = .white
        vc.title = "Journal"
        navigationController.setViewControllers([vc], animated: false)
    }
}
