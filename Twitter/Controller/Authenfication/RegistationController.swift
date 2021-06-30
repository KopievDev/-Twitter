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
//        iv.clipsToBounds = true
//        iv.layer.borderWidth = 1
//        iv.layer.borderColor = UIColor.white.cgColor
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
        button.addTarget(self, action: #selector(handleSighUp), for: .touchUpInside)
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
    
    @objc func handleSighUp() {
        let tabBar = MainTabController()
        dismiss(animated: true) {
            self.present(tabBar, animated: true)
        }
        
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
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        logoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddProfilePhoto)))

        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
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

extension RegistationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        setNew(image: image)
        dismiss(animated: true)
    }
    
    func setNew(image: UIImage) {
        logoImageView.image = image
        logoImageView.clipsToBounds = true
        logoImageView.layer.borderWidth = 3
        logoImageView.layer.borderColor = UIColor.white.cgColor
        logoImageView.layer.cornerRadius = 100
        logoImageView.contentMode = .scaleAspectFill
    }
    
}
