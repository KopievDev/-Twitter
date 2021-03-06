//
//  RegistationController.swift
//  Twitter
//
//  Created by Ivan Kopiev on 29.06.2021.
//

import UIKit
import Firebase

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
    
    let emailContainer = TextFieldView(placeholder: "Почта", image: "envelope")
    let passwordContainer = TextFieldView(placeholder: "Пароль", image: "lock")
    let fullnameContainer = TextFieldView(placeholder: "Полное имя", image: "person.crop.circle.badge.checkmark")
    let usernameContainer = TextFieldView(placeholder: "Логин", image: "person.crop.circle")
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.twitterBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(handleSighUp), for: .touchUpInside)
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Уже есть аккаунт? ",
                                                        attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
                                                                     NSAttributedString.Key.foregroundColor : UIColor.white])
        attributedTitle.append(NSAttributedString(string: "Войти", attributes:
                                                    [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
                                                     NSAttributedString.Key.foregroundColor : UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
        
    }()
    
    // Gradient
    let color1: CGColor = UIColor(red: 209/255, green: 107/255, blue: 165/255, alpha: 1).cgColor
    let color2: CGColor = UIColor(red: 134/255, green: 168/255, blue: 231/255, alpha: 1).cgColor
    let color3: CGColor = UIColor.twitterBlue.cgColor
    
    let gradient: CAGradientLayer = CAGradientLayer()
    var gradientColorSet: [[CGColor]] = []
    var colorIndex: Int = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        animateGradient()

        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    // MARK: - Selectors
    @objc func handleAddProfilePhoto() {
        animateView(logoImageView)
        present(imagePicker, animated: true)
    }
    
    @objc func handleSighUp() {
       
        let user = getDataFromVC()
        AuthService.shared.registrer(user: user) { [weak self] err in
            self?.showAlert(withError: err)
        }
        
    }
    
    func getDataFromVC() -> User {
        guard let mail = emailContainer.textField.text,
              let pass = passwordContainer.textField.text,
              let username = usernameContainer.textField.text,
              let fullname = fullnameContainer.textField.text,
              let profileImage = logoImageView.image,
              let imageData = profileImage.jpegData(compressionQuality: 0.3) else {
            fatalError("DEBUG: - error to get data from VC")
        }
        let user = User(mail: mail, password: pass, username: username, fullname: fullname, image: imageData)
        
        return user
    }
    
    func showAlert(withError error: Error?) {
        if let error = error {
            print("DEBUG: - \(error.localizedDescription)")
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Successed", message: "Пользователь зарегистрирован", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(alert, animated: true)
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

extension RegistationController: CAAnimationDelegate {
    
    func setupGradient(){
        gradientColorSet = [
            [color1, color2],
            [color2, color3],
            [color3, color1]
        ]
        
        gradient.frame = self.view.bounds
        gradient.colors = gradientColorSet[colorIndex]
        
        self.view.layer.addSublayer(gradient)
    }
    
    func animateGradient() {
        gradient.colors = gradientColorSet[colorIndex]
        
        let gradientAnimation = CABasicAnimation(keyPath: "colors")
        gradientAnimation.delegate = self
        gradientAnimation.duration = 3.0
        
        updateColorIndex()
        gradientAnimation.toValue = gradientColorSet[colorIndex]
        
        gradientAnimation.fillMode = .forwards
        gradientAnimation.isRemovedOnCompletion = false
        
        gradient.add(gradientAnimation, forKey: "colors")
    }
    
    func updateColorIndex(){
        if colorIndex < gradientColorSet.count - 1 {
            colorIndex += 1
        } else {
            colorIndex = 0
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            animateGradient()
        }
    }
}
