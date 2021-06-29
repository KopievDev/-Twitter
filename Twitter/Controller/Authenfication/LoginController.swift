//
//  LoginController.swift
//  Twitter
//
//  Created by Ivan Kopiev on 29.06.2021.
//

import UIKit

class LoginController: UIViewController {
    // MARK: - Properties
    private let logoImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "TwitterLogo"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let emailContainer = TextFieldView(placeholder: "Email", image: "envelope")
    let passwordContainer = TextFieldView(placeholder: "Password", image: "lock")
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.twitterBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 12
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 50)
        logoImageView.setDimensions(width: 100, height: 100)
        
        view.addSubview(emailContainer)
        emailContainer.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 50)
        view.addSubview(passwordContainer)
        passwordContainer.anchor(top: emailContainer.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 16, height: 50)
        passwordContainer.textField.isSecureTextEntry = true
        
        view.addSubview(loginButton)
        loginButton.anchor(top: passwordContainer.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16,paddingRight: 16, height: 50)
        
    }
}
