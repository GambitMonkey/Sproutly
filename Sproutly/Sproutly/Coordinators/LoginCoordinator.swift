//
//  LoginCoordinator.swift
//  Sproutly
//
//  Created by Deniz Turan Çağlarca on 19.08.2025.
//


import UIKit

final class LoginCoordinator: NavigationCoordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private let dependencies: AppDependencies
    
    var onFinish: (() -> Void)?
    
    init(dependencies: AppDependencies,
         navigationController: UINavigationController = UINavigationController()) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }
    
    func start() {
        let loginVC = LoginViewController()
        loginVC.onLogin = { [weak self] username, password in
            print("Login attempt with username: \(username), password: \(password)")
            self?.onFinish?()
        }
        
        navigationController.setViewControllers([loginVC], animated: false)
    }
}
