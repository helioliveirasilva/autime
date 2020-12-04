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
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var monButton: UIButton!
    @IBOutlet weak var tueButton: UIButton!
    @IBOutlet weak var wedButton: UIButton!
    @IBOutlet weak var thuButton: UIButton!
    @IBOutlet weak var friButton: UIButton!
    @IBOutlet weak var satButton: UIButton!
    @IBOutlet weak var sunButton: UIButton!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var viewFakeBar: UIView!
    
    //Variables
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext!
    var pressMon: Bool = false
    var pressTue: Bool = false
    var pressWed: Bool = false
    var pressThu: Bool = false
    var pressFri: Bool = false
    var pressSat: Bool = false
    var pressSun: Bool = false
    var categorias: [String] = ["Domésticas", "Higiene", "Educação", "Saúde", "Família", "Amigos", "Alimentação", "Entreterimento", "Prêmio", "Extras"]
    
    
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
        
        //Colors
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        popupView.backgroundColor = .white
        monButton.backgroundColor = .systemGray2
        tueButton.backgroundColor = .systemGray2
        wedButton.backgroundColor = .systemGray2
        thuButton.backgroundColor = .systemGray2
        friButton.backgroundColor = .systemGray2
        satButton.backgroundColor = .systemGray2
        sunButton.backgroundColor = .systemGray2
        
        //Labels
        labelNome.placeholder = "Escreva aqui"
        labelNome.font = .rounded(ofSize: 17, weight: .regular)
        nameLabel.font = .rounded(ofSize: 16, weight: .medium)
        timeLabel.font = .rounded(ofSize: 16, weight: .medium)
        starLabel.font = .rounded(ofSize: 16, weight: .medium)
        subActLabel.font = .rounded(ofSize: 16, weight: .medium)
        weekLabel.font = .rounded(ofSize: 16, weight: .medium)
        repeatLabel.font = .rounded(ofSize: 16, weight: .medium)
        categoryLabel.font = .rounded(ofSize: 16, weight: .medium)
        
        //Buttons
        self.monButton.layer.cornerRadius = 16
        self.tueButton.layer.cornerRadius = 16
        self.wedButton.layer.cornerRadius = 16
        self.thuButton.layer.cornerRadius = 16
        self.friButton.layer.cornerRadius = 16
        self.satButton.layer.cornerRadius = 16
        self.sunButton.layer.cornerRadius = 16
        self.saveButton.layer.cornerRadius = 14
        saveButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
        saveButton.titleLabel?.font = .rounded(ofSize: 16, weight: .medium)
        imageButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        imageButton.layer.masksToBounds = true
        imageButton.layer.cornerRadius = 21
        
        //Switchs
        repeatSwitch.onTintColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
        switchEstrela.onTintColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
        
        //NavBar
        self.title = "Criar Atividade"
        navigationController?.isNavigationBarHidden = false
        
        //PopUpView
        popupView.layer.cornerRadius = 21
        popupView.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        popupView.layer.shadowOpacity = 0.15
        popupView.layer.shadowRadius = 30.0
        
        //FakeNavBar
        self.viewFakeBar.layer.cornerRadius = 21
        viewFakeBar.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
        viewFakeBar.layer.shadowColor = UIColor.black.cgColor
        viewFakeBar.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        viewFakeBar.layer.shadowOpacity = 0.5
        viewFakeBar.layer.shadowRadius = 4.0
        
        
    }
    
    //Escolher Imagem
    @IBAction func escolherImagem(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
        
    }
    
    //PickerCOntroller
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            imageButton.setImage(image, for: .normal)
            picker.dismiss(animated: true, completion: nil)

        }
    }
    
    
    //PickerControllerCancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //Salvar
    @IBAction func salvar(_ sender: Any) {
                
        let atividade = Atividade(context: self.context)
        atividade.nome = self.labelNome.text ?? "Sem Nome"
        atividade.horario = self.pickerHora.date
        atividade.gerarEstrela = self.switchEstrela.isOn
        atividade.image = imageButton.image(for: .normal)?.pngData()
        atividade.segunda = self.pressMon
        atividade.terca = self.pressTue
        atividade.quarta = self.pressWed
        atividade.quinta = self.pressThu
        atividade.sexta = self.pressFri
        atividade.sabado = self.pressSat
        atividade.domingo = self.pressSun

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
    
    //Weekday Selection
    @IBAction func weekTouch(_ sender: UIButton) {
        if sender == monButton {
            pressMon = !pressMon // inverte o booleano
            if pressMon {
                monButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
            } else {
                monButton.backgroundColor = .systemGray2
            }
            
        } else if sender == tueButton {
            pressTue = !pressTue // inverte o booleano
            if pressTue {
                tueButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
            } else {
                tueButton.backgroundColor = .systemGray2
            }
            
        } else if sender == wedButton {
            pressWed = !pressWed // inverte o booleano
            if pressWed {
                wedButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
            } else {
                wedButton.backgroundColor = .systemGray2
            }
            
        } else if sender == thuButton {
            pressThu = !pressThu // inverte o booleano
            if pressThu {
                thuButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
            } else {
                thuButton.backgroundColor = .systemGray2
            }
            
        } else if sender == friButton {
            pressFri = !pressFri // inverte o booleano
            if pressFri {
                friButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
            } else {
                friButton.backgroundColor = .systemGray2
            }
            
        } else if sender == satButton {
            pressSat = !pressSat // inverte o booleano
            if pressSat {
                satButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
            } else {
                satButton.backgroundColor = .systemGray2
            }
            
        } else if sender == sunButton {
            pressSun = !pressSun // inverte o booleano
            if pressSun {
                sunButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
            } else {
                sunButton.backgroundColor = .systemGray2
            }
        }
    }
    //End
}

