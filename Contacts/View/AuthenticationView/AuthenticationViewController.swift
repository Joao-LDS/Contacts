//
//  AuthenticationViewController.swift
//  Contacts
//
//  Created by João Luis Santos on 15/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {

    let viewModel: AuthenticationViewModel
    var uiview: AuthenticationView
    
    init(viewModel: AuthenticationViewModel) {
        self.viewModel = viewModel
        uiview = AuthenticationView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.delegate = self
    }
    
    override func loadView() {
        self.view = uiview
    }
    
    func configureView() {
        uiview.dontHaveAnAccountButton.addTarget(self, action: #selector(self.tappedCreateAnAccount), for: .touchUpInside)
        uiview.signButton.addTarget(self, action: #selector(self.tappedSignInUser), for: .touchUpInside)
    }
    
    @objc func tappedSignInUser() {
        guard let email = uiview.emailTextField.textField.text,
            let password = uiview.passwordTextField.textField.text else { return }
        
        viewModel.signInUser(email, password: password)
    }
    
    @objc func tappedCreateAnAccount() {
        let  viewModel = RegistrationViewModel()
        let controller = RegistrationViewController(viewModel: viewModel)
        present(controller, animated: true)
    }
}

extension AuthenticationViewController: SignErrorDelegate {
    func showAlertWithError(message: String) {
        let alert = UIAlertController().create(title: nil, message: message, preferredStyle: .alert, actions: [])
        present(alert, animated: true)
    }
}
