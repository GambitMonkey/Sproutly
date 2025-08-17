//
//  ProfileViewController.swift
//  Sproutly
//
//  Created by Deniz Turan Çağlarca on 17.08.2025.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    var onLogout: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
    }
    
    private func setupButton() {
        let button = UIButton(type: .system)
        button.setTitle(Strings.Login.logOutText, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapGetStarted), for: .touchUpInside)
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
    
    @objc private func didTapGetStarted() {
        onLogout?()
    }
}
