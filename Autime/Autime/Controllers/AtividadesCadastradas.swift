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
    
    //Outlets
    @IBOutlet weak var labelNome: UITextField!
    @IBOutlet weak var pickerHora: UIDatePicker!
    @IBOutlet weak var switchEstrela: UISwitch!
    @IBOutlet weak var repeatSwitch: UISwitch!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var repeatLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var subActLabel: UILabel!
    @IBOutlet weak var monButton: UIButton!
    @IBOutlet weak var tueButton: UIButton!
    @IBOutlet weak var wedButton: UIButton!
    @IBOutlet weak var thuButton: UIButton!
    @IBOutlet weak var friButton: UIButton!
    @IBOutlet weak var satButton: UIButton!
    @IBOutlet weak var sunButton: UIButton!
    
    //Variables
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext!
    var pressMonday: Bool = false
    
    //ViewDidLoad
    override func viewDidLoad() {
        self.context = appDelegate.persistentContainer.viewContext
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)

        self.labelNome.delegate = self
        self.labelNome.addDoneButtonToKeyboard(myAction:  #selector(self.labelNome.resignFirstResponder))
        
    }
    
    //ViewWillAppear
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
            imageButton.setImage(image, for: .normal)
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
        atividade.image = imageButton.image(for: .normal)?.pngData()
        atividade.segunda = self.pressMonday
//        atividade.terca = self.switchTerca.isOn
//        atividade.quarta = self.switchQuarta.isOn
//        atividade.quinta = self.switchQuinta.isOn
//        atividade.sexta = self.switchSexta.isOn
//        atividade.sabado = self.switchSabado.isOn
//        atividade.domingo = self.switchDomingo.isOn

        
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
    
    @IBAction func weekTouch(_ sender: UIButton) {
        if sender == monButton {
            pressMonday = !pressMonday // inverte o booleano

            if pressMonday {
                monButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
            } else {
                monButton.backgroundColor = .systemGray2
            }
            
        }
        else if sender == tueButton {
            
        }
    }
    
    
}

