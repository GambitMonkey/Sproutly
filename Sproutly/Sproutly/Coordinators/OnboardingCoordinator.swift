//
//  OnboardingCoordinator.swift
//  Sproutly
//
//  Created by Deniz Turan Çağlarca on 12.08.2025.
//


import UIKit

final class OnboardingCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private let dependencies: AppDependencies
    var onFinish: (() -> Void)?

    // Root VC for this coordinator
    let rootViewController: UIViewController
    
    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
        self.rootViewController = OnboardingViewController()
    }
    
    func start() {
        if let onboardingVC = rootViewController as? OnboardingViewController {
            onboardingVC.onFinish = { [weak self] in
                self?.onFinish?()
            }
        }
    }
}

