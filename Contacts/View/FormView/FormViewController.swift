//
//  ViewController.swift
//  Contacts
//
//  Created by João Santos on 15/02/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {
    
    // MARK: - Attributes
    
    var activeTextField: UITextField? // Guarda o text field atual para ser usado em UITextFieldDelegate
    var uiview: FormView
    let viewModel: FormViewModel
    
    init(viewModel: FormViewModel) {
        self.viewModel = viewModel
        uiview = FormView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = uiview
    }

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        // Delegate UITextFieldDelegate
        self.uiview.nameTf.textField.delegate = self
        self.uiview.phoneTf.textField.delegate = self
        self.uiview.emailTf.textField.delegate = self
        self.uiview.addressTf.textField.delegate = self
        
        // Observador para o teclado, fica monitorando quando o teclado tem alguma mudança
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    // MARK: - Functions
    
    func configureView() {
        uiview.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tappedPhoto(_:))))
        uiview.addButton.addTarget(self, action: #selector(self.addContact), for: .touchUpInside)
        uiview.groupTypeButton.addTarget(self, action: #selector(self.tappedGroup), for: .touchUpInside)
        uiview.backButton.addTarget(self, action: #selector(self.tappedBack), for: .touchUpInside)
    }
    
    // MARK: - Functions to Actions and Alert
    
    func showActionSheet() {
        var actions: [UIAlertAction] = []
        
        // Opção Galeria
        actions.append(UIAlertAction(title: "Galeria", style: .default, handler: { _ in
            self.selectedPhoto(sourceType: .photoLibrary)
        }))
        
        // Opção Câmera
        actions.append(UIAlertAction(title: "Câmera", style: .default, handler: { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) { // Verifica se há camera disponivel no device
                self.selectedPhoto(sourceType: .camera)
            } else {
                self.showAlert(with: nil, "A câmera não está disponível")
            }
        }))
        
        // Se houver foto selecionada, mostra opção Limpar foto
        if uiview.imageView.image != UIImage(named: "userDefaultImage") {
            actions.append(UIAlertAction(title: "Limpar foto",
                                                style: .default,
                                                handler: { _ in
            self.uiview.imageView.image = UIImage(named: "userDefaultImage")
            }))
        }
        
        let actionSheet = UIAlertController().create(title: nil,
                                                     message: "Por favor, selecione de onde você quer a foto.",
                                                     preferredStyle: .actionSheet,
                                                     actions: actions)
        
        self.present(actionSheet, animated: true)
    }
    
    func showAlert(with title: String?,_ message: String) {
        let alert = UIAlertController().create(title: title, message: message, preferredStyle: .alert, actions: nil)
        present(alert, animated: true)
    }
    
    // MARK: - Functions to Take Photo
    
    func selectedPhoto(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Selectors
    
    @objc func addContact() {
        guard let name = uiview.nameTf.textField.text,
            let phone = uiview.phoneTf.textField.text,
            let email = uiview.emailTf.textField.text,
            let address = uiview.addressTf.textField.text,
            let photo = uiview.imageView.image else { return }
        
        if viewModel.addContact(with: name, phone, email, address, photo) {
            dismiss(animated: true)
            return
        }
        showAlert(with: "Desculpe", "Não possível é adicionar um contato sem nome.")
    }
    
    @objc func tappedPhoto(_ gesture: UITapGestureRecognizer) {
        showActionSheet()
    }
    
    @objc func tappedGroup() {
        // GroupViewModel recebe self.viewModel por conta de usar o protocol FormViewModelDelegate
        let viewModel = GroupViewModel(viewModel: self.viewModel)
        let controller = GroupViewController(viewModel: viewModel)
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    @objc func tappedBack() {
        dismiss(animated: true)
    }
    
    // Faz a tela scrollar quando o teclado fica na frente do text field
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return } // Recupera o tamanho do teclado
        var moveViewUp = false
        if let activeTextField = activeTextField {
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY // Recupera a distância entre a parte de baixo do text field até o topo da view(y)
            let topOfKeyboard = self.view.frame.height - keyboardSize.height // Diferença entre a altura da view e do teclado
            if bottomOfTextField > topOfKeyboard {
                moveViewUp = true
            }
            if moveViewUp {
                self.view.frame.origin.y = -keyboardSize.height
            }
        }
    }
    
    // Rotorna a view para posição de origem quando o teclado desaparece
    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    /* Será feito na branch de edição
    func setupGroupButton() {
        if let group = viewModel.delegate?.selectedGroup {
            let attr = NSAttributedString(string: group.name!, attributes: [.font: UIFont(name: "Avenir", size: 18)!, .foregroundColor: UIColor.systemGray])
            uiview.groupTypeButton.setAttributedTitle(attr, for: .normal)
        }
    }
    
    func configureViewWithContact() {
        guard let contact = viewModel.contact else { return }
        uiview.imageView.image = contact.photo as? UIImage
        uiview.nameTf.textField.text = contact.name
        uiview.phoneTf.textField.text = contact.phone
        uiview.addressTf.textField.text = contact.address
        let group = contact.group?.name
        let attr = NSAttributedString(string: group!, attributes: [.font: UIFont(name: "Avenir", size: 18)!, .foregroundColor: UIColor.systemGray])
        uiview.groupTypeButton.setAttributedTitle(attr, for: .normal)
    }
    */
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension FormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage { // A img selecionada fica dentro do dic info, é recuperada e convertida para UIImage
            uiview.imageView.image = image
            dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - UITextFieldDelegate

extension FormViewController: UITextFieldDelegate {
    
    // Desaparece o teclado quando clicar em return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Seta o activeTextField com o textField atual quando ele é selecionado
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
}
