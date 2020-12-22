//
//  RecoveryPasswordViewController.swift
//  Contacts
//
//  Created by João Luis Santos on 21/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class RecoveryPasswordViewController: UIViewController {
    
    let viewModel: RecoveryPasswordViewModel
    var uiview: RecoveryPasswordView
    
    init(viewModel: RecoveryPasswordViewModel) {
        self.viewModel = viewModel
        uiview = RecoveryPasswordView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.signErrorDescription = self
        viewModel.dismissViewDelegate = self
        configureView()
    }
    
    override func loadView() {
        self.view = uiview
    }
    
    func configureView() {
        uiview.closeButton.addTarget(self, action: #selector(self.tappedClose), for: .touchUpInside)
        uiview.okButton.addTarget(self, action: #selector(self.tappedOk), for: .touchUpInside)
    }
    
    @objc func tappedClose() {
        dismiss(animated: true)
    }
    
    @objc func tappedOk() {
        guard let email = uiview.emailRecoveryPassTextField.textField.text else { return }
        viewModel.send(Email: email)
    }
}

extension RecoveryPasswordViewController: SignErrorDelegate {
    func showAlertWithError(message: String) {
        let alert = UIAlertController().create(title: nil, message: message, preferredStyle: .alert, actions: [])
        present(alert, animated: true)
    }
}

extension RecoveryPasswordViewController: DismissViewDelegate {
    func dismissRecoveryView() {
        dismiss(animated: true)
    }
}
