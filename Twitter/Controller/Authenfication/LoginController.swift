//
//  LoginController.swift
//  Twitter
//
//  Created by Ivan Kopiev on 29.06.2021.
//

import UIKit

class LoginController: UIViewController {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
    }
}
