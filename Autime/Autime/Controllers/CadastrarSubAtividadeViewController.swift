//
//  CadastrarSubAtividadeViewController.swift
//  Autime
//
//  Created by Matheus Andrade on 10/12/20.
//
// swiftlint:disable force_cast
// swiftlint:disable line_length
// swiftlint:disable trailing_whitespace
// swiftlint:disable vertical_whitespace
// swiftlint:disable weak_delegate
// swiftlint:disable opening_brace
// swiftlint:disable colon
// swiftlint:disable trailing_newline

import UIKit
import CoreData

class CadastrarSubAtividadeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext!
    var subAtividade: SubAtividade!
    var atividadesCadastradas:AtividadesCadastradas?
    var editAtividade: ThisWeekEditActViewController?
    var allActFocus: AllActFocusViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        context = appDelegate.persistentContainer.viewContext
        
        imageButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        imageButton.layer.masksToBounds = true
        imageButton.layer.cornerRadius = 21
        
        contentView.layer.cornerRadius = 21
        
        self.nameTextField.addDoneButtonToKeyboard(myAction:  #selector(self.nameTextField.resignFirstResponder))

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/2.5
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    
    @IBAction func createTap() {
        self.subAtividade = SubAtividade(context: self.context)
        self.subAtividade.image = self.imageButton.imageView?.image?.pngData()
        self.subAtividade.nome = self.nameTextField.text
        
        if let cadastro = atividadesCadastradas {
            cadastro.onUserAction(subAtividade: subAtividade)
        }
        
        if let edit = editAtividade {
            edit.onUserAction(subAtividade: subAtividade)
        }
        
        if let allAct = allActFocus {
            allAct.onUserAction(subAtividade: subAtividade)
        }

        dismiss(animated: true, completion: nil)
        
    }
    
}

extension CadastrarSubAtividadeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Escolher Imagem
    @IBAction func escolherImagem(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    // PickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            imageButton.setImage(image, for: .normal)
            picker.dismiss(animated: true, completion: nil)
            
        }
    }
    
    // PickerControllerCancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
