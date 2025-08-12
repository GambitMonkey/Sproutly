//
//  Coordinator.swift
//  Sproutly
//
//  Created by Deniz Turan Çağlarca on 11.08.2025.
//


import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set } 
    func start()
}

extension Coordinator {
    func addChild(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    func removeChild(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}

