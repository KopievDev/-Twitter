//
//  RegistationController.swift
//  Twitter
//
//  Created by Ivan Kopiev on 29.06.2021.
//

import UIKit

class RegistationController: UIViewController {
    // MARK: - Properties
    private let logoImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "photo"))
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    let imagePicker = UIImagePickerController()
    
    let emailContainer = TextFieldView(placeholder: "Email", image: "envelope")
    let passwordContainer = TextFieldView(placeholder: "Password", image: "lock")
    let fullnameContainer = TextFieldView(placeholder: "Full Name", image: "person.crop.circle.badge.checkmark")
    let usernameContainer = TextFieldView(placeholder: "Username", image: "person.crop.circle")
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sigh Up", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.twitterBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 12
//        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Alredy have an account? ",
                                                        attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
                                                                     NSAttributedString.Key.foregroundColor : UIColor.white])
        attributedTitle.append(NSAttributedString(string: "Log In", attributes:
                                                    [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
                                                     NSAttributedString.Key.foregroundColor : UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
        
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    // MARK: - Selectors
    @objc func handleAddProfilePhoto() {
        animateView(logoImageView)
        present(imagePicker, animated: true)
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        view.addSubview(logoImageView)
        view.addSubview(emailContainer)
        view.addSubview(passwordContainer)
        view.addSubview(fullnameContainer)
        view.addSubview(usernameContainer)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        logoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddProfilePhoto)))

        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 50)
        logoImageView.setDimensions(width: 200, height: 200)
        
        emailContainer.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 50)
        passwordContainer.anchor(top: emailContainer.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 50)
        fullnameContainer.anchor(top: passwordContainer.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 50)
        usernameContainer.anchor(top: fullnameContainer.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 50)
        signUpButton.anchor(top: usernameContainer.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16,paddingRight: 16, height: 50)
        loginButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,height: 50)
        
        
    }
    private func animateView(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: .curveEaseIn) {
            viewToAnimate.transform = .identity
            
        }
    }
}

extension RegistationController: UIImagePickerControllerDelegate {
    
}
