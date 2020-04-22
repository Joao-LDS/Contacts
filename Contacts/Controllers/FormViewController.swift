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
    var contact: Contact! // Se null add
    let typeManager = TypeManager.shared // Dá acesso ao array de Types
    var activeTextField: UITextField? = nil // Guarda o text field atual para ser usado em UITextFieldDelegate
    
    lazy var pickerView: UIPickerView = { // lazy - só constrói uma clase quando vamos utiliza la
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        return pickerView
    }()

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Verifica se é uma adição ou edição
        if contact != nil {
            if let image = contact.image as? UIImage {
                self.imageContact.image = image
            }
            self.nameTextField.text = contact.name
            self.numberPhoneTextField.text = contact.phoneNumber
            self.emailTextField.text = contact.email
            self.addressTextField.text = contact.address
            if let type = contact.type, let index = typeManager.types.index(of: type) {
                typeOfContactTextField.text = type.name
                pickerView.selectRow(index, inComponent: 0, animated: false)
            }
            self.buttonAdd.setTitle("Change", for: .normal)
        }
        
        // Estilo
        bottomLineTextField(textField: nameTextField)
        bottomLineTextField(textField: numberPhoneTextField)
        bottomLineTextField(textField: emailTextField)
        bottomLineTextField(textField: addressTextField)
        bottomLineTextField(textField: typeOfContactTextField)
        self.buttonAdd.layer.cornerRadius = 5.0
        viewWithBorderAndShadow(self.viewEffect, cornerRadius: 20.0)
        imageContatctViewStyle()
        
        // Delegate UITextFieldDelegate
        self.nameTextField?.delegate = self
        self.numberPhoneTextField.delegate = self
        self.emailTextField.delegate = self
        self.addressTextField.delegate = self
        self.typeOfContactTextField.delegate = self
        
        // PickerView
        typeOfContactTextField.inputView = pickerView // Ao clicar no textField em vez de abrir o teclado irá abrir o pickerView
        typeOfContactTextField.inputAccessoryView = toolbar()

        // Observador para o teclado, fica monitorando quando o teclado tem laguma mudança
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        typeManager.loadTypes(with: context) // Carrega os tipo de contatos
    }

    // MARK: - IBOutlet
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberPhoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var typeOfContactTextField: UITextField!
    @IBOutlet weak var imageContact: UIImageView!
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var viewEffect: UIView!
    @IBOutlet weak var viewWithBorderShadow: UIView!

    // MARK: - IBAction
    
    @IBAction func add(_ sender: Any) {
        
        guard let name = nameTextField.text else { return }
        guard let numberPhone = numberPhoneTextField.text else { return }
        guard let email = emailTextField.text else { return }
        guard let address = addressTextField.text else { return }
        
        if !name.isEmpty { // Verifica se o nome foi preenchido
            if contact == nil { // Se o contact for nil indica que é um novo contact que será adicionado
                self.contact = Contact(context: context) // Instancia um objeto Contact com o contexto do CoreData
            }
            self.contact.name = name
            self.contact.phoneNumber = numberPhone
            self.contact.email = email
            self.contact.address = address
            if !typeOfContactTextField.text!.isEmpty {
                let type = typeManager.types[pickerView.selectedRow(inComponent: 0)] // Busca
                contact.type = type
            }
            contact.image = imageContact.image
            do {
                try context.save() // Salva o contact
            } catch {
                print(error.localizedDescription)
            }
            self.navigationController?.popViewController(animated: true)
        } else {
           self.showAlert(with: "It's not possible to add contact without a name.")
        }
    }
    
    @IBAction func imageButton(_ sender: Any) {
        showAlertAction()
    }

    // MARK: - Methods
    
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
        if notification.name == UIResponder.keyboardWillShowNotification {
            print(view.frame.origin.y)
            print(view.frame.origin.y)
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    // Estilo dos text fields
    func bottomLineTextField(textField: UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(named: "second")?.cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
    }
    
    func showAlertAction() {
        let actionSheet = UIAlertController(title: "Image", message: "Please, select an image for the contact.", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Library", style: .default, handler: { (_) in
            self.selectedImage(sourceType: .photoLibrary)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            let camera = UIImagePickerController.isSourceTypeAvailable(.camera) // Verifica se há camera disponivel no device
            if camera {
                self.selectedImage(sourceType: .camera)
            } else {
                self.showAlert(with: "Camera is not available!")
            }
        }))
        
        if self.imageContact.image != UIImage(named: "userDefaultImage") {
            actionSheet.addAction(UIAlertAction(title: "Clear photo", style: .default, handler: { (_) in
                self.imageContact.image = UIImage(named: "userDefaultImage")
            }))
        }

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func selectedImage(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func showAlert(with message: String) {
        let alert = UIAlertController(title: "Sorry", message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.view.tintColor = UIColor(named: "second") // Cor texto do botão
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
    
    func toolbar() -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 47))
        toolbar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        toolbar.tintColor = UIColor(named: "second")
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) // Adiciona espaço entre os botões
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToobar))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.items = [cancelButton, flexibleSpace, addButton, flexibleSpace, doneButton]
        return toolbar
    }
    
    @objc func cancel() {
        typeOfContactTextField.resignFirstResponder() // Faz o input do text field desaparecer
    }
    
    @objc func addToobar() {
        showAlertAddType(with: nil)
    }
    
    @objc func done() {
        typeOfContactTextField.text = typeManager.types[pickerView.selectedRow(inComponent: 0)].name // pickerView.selectedRow(inComponent: 0) é a posição da linha do picker view, como esse tem apenas uma linha, então é 0
        cancel()
    }
    
    func showAlertAddType(with type: TypeOfContact?) {
        let title = type == nil ? "Add" : "Remove"
        let alert = UIAlertController(title: title + " type of contact", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "The type of contact is.."
            if let name = type?.name { // Se não for nulo indica q é uma edição, ai passa o nama para o campo
                textField.text = name
            }
        }
        alert.addAction(UIAlertAction(title: title, style: .default, handler: { (action) in
            // Se estiver adicionando vamos criar um novo type, se editando recuperamos o type
            let type = type ?? TypeOfContact(context: self.context) // Se o type n for nulo, let type = type, caso contrário cria um novo
            type.name = alert.textFields?.first?.text // alert.textFields?.first?.text retorna o text do primeiro textField do alert, podem ser vários, alert.textFields devolve um array de text fields
            do {
                try self.context.save()
                self.typeManager.loadTypes(with: self.context)
            } catch {
                print(error.localizedDescription)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.view.tintColor = UIColor(named: "second")
        present(alert, animated: true, completion: nil)
    }
    
    func imageContatctViewStyle() {
        viewWithBorderAndShadow(self.viewWithBorderShadow, cornerRadius: 5.0)
        if imageContact.image == nil {
            self.imageContact.image = UIImage(named: "userDefaultImage")
        }
        self.imageContact.layer.cornerRadius = 5.0
        self.imageContact.layer.masksToBounds = true
    }
    
    func viewWithBorderAndShadow(_ vw: UIView, cornerRadius: CGFloat) {
        vw.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        vw.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        vw.layer.shadowOpacity = 0.30
        vw.layer.shadowRadius = 5.0
        vw.layer.cornerRadius = cornerRadius
    }
}


extension FormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage { // A img selecionada fica dentro do dic info, é recuperada e convertida para UIImage
            self.imageContact.image = image
            dismiss(animated: true, completion: nil)
        }
    }
}


extension FormViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeManager.types.count // Acesso ao array de Types
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let type = typeManager.types[row]
        return type.name
    }
}

extension FormViewController: UITextFieldDelegate {
    
    // Desaparece o telcado quando clicar em return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Seta o acticeTextField com o textField atual
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    // Quando click em return ou desaparece o teclado
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
}
