//
//  LoginViewController.swift
//  Sproutly
//
//  Created by Deniz Turan Çağlarca on 19.08.2025.
//


import UIKit

final class LoginViewController: UIViewController {
    
    var onLogin: ((String, String) -> Void)?
    
    private let usernameField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = Strings.Login.usernameText
        textfield.borderStyle = .roundedRect
        textfield.autocapitalizationType = .none
        return textfield
    }()
    
    private let passwordField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = Strings.Login.passwordText
        textfield.borderStyle = .roundedRect
        textfield.isSecureTextEntry = true
        return textfield
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Strings.Login.loginText, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let stack = UIStackView(arrangedSubviews: [usernameField, passwordField, loginButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        usernameField.accessibilityIdentifier = "usernameField"
        passwordField.accessibilityIdentifier = "passwordField"
        loginButton.accessibilityIdentifier = "loginButton"
    }
    
    @objc private func loginTapped() {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        onLogin?(username, password)
    }
}
