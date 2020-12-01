//
//  File.swift
//  Autime
//
//  Created by Hélio Silva on 23/11/20.
//

import UIKit
import CoreData

class AtividadesCadastradas: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // swiftlint:disable force_cast
    // swiftlint:disable line_length
    // swiftlint:disable trailing_whitespace
    // swiftlint:disable vertical_whitespace
    // swiftlint:disable weak_delegate
    // swiftlint:disable opening_brace
    // swiftlint:disable colon
    // swiftlint:disable trailing_newline
    
    @IBOutlet weak var labelNome: UITextField!
    @IBOutlet weak var pickerHora: UIDatePicker!
    @IBOutlet weak var switchEstrela: UISwitch!
    @IBOutlet weak var switchSegunda: UISwitch!
    @IBOutlet weak var switchTerca: UISwitch!
    @IBOutlet weak var switchQuarta: UISwitch!
    @IBOutlet weak var switchQuinta: UISwitch!
    @IBOutlet weak var switchSexta: UISwitch!
    @IBOutlet weak var switchSabado: UISwitch!
    @IBOutlet weak var switchDomingo: UISwitch!
    @IBOutlet weak var imageView: UIImageView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        self.context = appDelegate.persistentContainer.viewContext
        self.imageView.image = UIImage()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)

        self.labelNome.delegate = self
        self.labelNome.addDoneButtonToKeyboard(myAction:  #selector(self.labelNome.resignFirstResponder))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //NavBar
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func escolherImagem(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            imageView.image = image
            picker.dismiss(animated: true, completion: nil)

        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func salvar(_ sender: Any) {
                
        let atividade = Atividade(context: self.context)
        atividade.nome = self.labelNome.text ?? "Sem Nome"
        atividade.horario = self.pickerHora.date
        atividade.gerarEstrela = self.switchEstrela.isOn
        atividade.segunda = self.switchSegunda.isOn
        atividade.terca = self.switchTerca.isOn
        atividade.quarta = self.switchQuarta.isOn
        atividade.quinta = self.switchQuinta.isOn
        atividade.sexta = self.switchSexta.isOn
        atividade.sabado = self.switchSabado.isOn
        atividade.domingo = self.switchDomingo.isOn
        atividade.image = imageView.image?.pngData()
        
        // Criando Sub-Atividades
        for index in 1...10 {
            let step: SubAtividade! = SubAtividade(context: self.context)
            step.nome = "Step\(index)"
            step.image = UIImage(named: "test1.jpeg")?.pngData()
            step.ordem = Int16(index)
            atividade.addToPassos(step)
        }
        
        
        do {
            try self.context.save()
            print("Seus dados foram salvos corretamente")
        } catch {
            print("Erro ao salvar os dados")
        }
    }
    
    @IBAction func imprimir(_ sender: Any) {
        // Action de Imprimir na TableView -> Segue Storyboard
    }
    
}

extension UITextField{
    
    func addDoneButtonToKeyboard(myAction:Selector?){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Retornar", style: UIBarButtonItem.Style.done, target: self, action: myAction)
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
}
