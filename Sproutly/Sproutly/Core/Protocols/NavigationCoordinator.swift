//
//  NavigationCoordinator.swift
//  Sproutly
//
//  Created by Deniz Turan Çağlarca on 17.08.2025.
//

import UIKit

protocol NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController { get set }
}
