//
//  File.swift
//  Autime
//
//  Created by Hélio Silva on 23/11/20.
//

import UIKit
import CoreData

class AtividadesCadastradas: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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
        
        let atividade = NSEntityDescription.insertNewObject(forEntityName: "Atividade", into: self.context)
        atividade.setValue(self.labelNome.text, forKey: "nome")
        atividade.setValue(self.pickerHora.date, forKey: "horario")
        atividade.setValue(self.switchEstrela.isOn, forKey: "gerarEstrela")
        atividade.setValue(self.switchSegunda.isOn, forKey: "segunda")
        atividade.setValue(self.switchTerca.isOn, forKey: "terca")
        atividade.setValue(self.switchQuarta.isOn, forKey: "quarta")
        atividade.setValue(self.switchQuinta.isOn, forKey: "quinta")
        atividade.setValue(self.switchSexta.isOn, forKey: "sexta")
        atividade.setValue(self.switchSabado.isOn, forKey: "sabado")
        atividade.setValue(self.switchDomingo.isOn, forKey: "domingo")
        atividade.setValue(imageView.image?.pngData(), forKey: "image")
        
        
      
        
        do {
            try self.context.save()
            print("Seus dados foram salvos corretamente")
        } catch {
            print("Erro ao salvar os dados")
        }
    }
    
    @IBAction func imprimir(_ sender: Any) {
       
        
    }
    
    
    func salvarDados() {
        
        let novaAtividade = NSEntityDescription.insertNewObject(forEntityName: "Atividade", into: context)
        
        novaAtividade.setValue(self.labelNome.text, forKey: "nome")
        novaAtividade.setValue(self.pickerHora.date, forKey: "horario")
        novaAtividade.setValue(self.switchEstrela.isOn, forKey: "gerarEstrela")
        novaAtividade.setValue(self.switchSegunda.isOn, forKey: "segunda")
        novaAtividade.setValue(self.switchTerca.isOn, forKey: "terca")
        novaAtividade.setValue(self.switchQuarta.isOn, forKey: "quarta")
        novaAtividade.setValue(self.switchQuinta.isOn, forKey: "quinta")
        novaAtividade.setValue(self.switchSexta.isOn, forKey: "sexta")
        novaAtividade.setValue(self.switchSabado.isOn, forKey: "sabado")
        novaAtividade.setValue(self.switchDomingo.isOn, forKey: "domingo")
        
        
        do {
            try context.save()
            print("Seus dados foram salvos!")
        } catch let erro as Error{
            print("Erro ao salvar a anotação: \(erro.localizedDescription)")
        }
        
    }
}


