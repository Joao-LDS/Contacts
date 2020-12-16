//
//  RegistrationViewController.swift
//  Contacts
//
//  Created by João Luis Santos on 15/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    let viewModel: RegistrationViewModel
    var uiview: RegistrationView
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        uiview = RegistrationView()
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
        uiview.signButton.addTarget(self, action: #selector(self.tappedSignUp), for: .touchUpInside)
        uiview.iHaveAnAccountButton.addTarget(self, action: #selector(self.tappedIHaveAnAccount), for: .touchUpInside)
    }
    
    @objc func tappedSignUp() {
        guard let password = uiview.passwordTextField.textField.text,
            let passwordAgain = uiview.confirmPasswordTextField.textField.text,
            let email = uiview.emailTextField.textField.text else { return }
        viewModel.signUpUser(email, password, passwordAgain)
    }
    
    @objc func tappedIHaveAnAccount() {
        dismiss(animated: true)
    }

}

extension RegistrationViewController: SignErrorDelegate {
    func showAlertWithError(message: String) {
        let alert = UIAlertController().create(title: nil, message: message, preferredStyle: .alert, actions: [])
        present(alert, animated: true)
    }
}
