//
//  ThisWeekAddFocusViewController.swift
//  Autime
//
//  Created by Luis Eduardo Ramos on 08/12/20.
//

import UIKit

// swiftlint:disable force_cast
// swiftlint:disable line_length
// swiftlint:disable trailing_whitespace
// swiftlint:disable vertical_whitespace

class ThisWeekAddFocusViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var actNameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var subActLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var repeatLabel: UILabel!
    @IBOutlet weak var monButton: UIButton!
    @IBOutlet weak var tueButton: UIButton!
    @IBOutlet weak var wedButton: UIButton!
    @IBOutlet weak var thuButton: UIButton!
    @IBOutlet weak var friButton: UIButton!
    @IBOutlet weak var satButton: UIButton!
    @IBOutlet weak var sunButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var weeklySwitch: UISwitch!
    @IBOutlet weak var starSwitch: UISwitch!
    @IBOutlet weak var pickerView: UIDatePicker!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var viewFakeBar: UIView!
    @IBOutlet weak var imageButton: UIButton!
    
    //Variables
    var actNameInfo: String = "Erro"
    var isPressedMon: Bool = false
    var isPressedTue: Bool = false
    var isPressedWed: Bool = false
    var isPressedThu: Bool = false
    var isPressedFri: Bool = false
    var isPressedSat: Bool = false
    var isPressedSun: Bool = false
//    var activity: Atividade! {
//        didSet {
//            self.configureScreen()
//        }
//    }
    
    //Actions DailyButtons
    @IBAction func monButtonAction(_ sender: Any) {
        if isPressedMon == false {
            isPressedMon = true
            monButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
            return
        }
        if isPressedMon == true {
            isPressedMon = false
            print("test")
            monButton.backgroundColor = .systemGray2
            return
        }
    }
    @IBAction func tueButtonAct(_ sender: Any) {
        if isPressedTue == false {
            isPressedTue = true
            tueButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
            return
        }
        if isPressedTue == true {
            isPressedTue = false
            print("test")
            tueButton.backgroundColor = .systemGray2
            return
        }
    }
    @IBAction func wedButtonAct(_ sender: Any) {
        if isPressedWed == false {
            isPressedWed = true
            wedButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
            return
        }
        if isPressedWed == true {
            isPressedWed = false
            print("test")
            wedButton.backgroundColor = .systemGray2
            return
        }
    }
    @IBAction func thuButtonAct(_ sender: Any) {
        if isPressedThu == false {
            isPressedThu = true
            thuButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
            return
        }
        if isPressedThu == true {
            isPressedThu = false
            print("test")
            thuButton.backgroundColor = .systemGray2
            return
        }
    }
    @IBAction func friButtonAct(_ sender: Any) {
        if isPressedFri == false {
            isPressedFri = true
            friButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
            return
        }
        if isPressedFri == true {
            isPressedFri = false
            print("test")
            friButton.backgroundColor = .systemGray2
            return
        }
    }
    @IBAction func satButtonAct(_ sender: Any) {
        if isPressedSat == false {
            isPressedSat = true
            satButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
            return
        }
        if isPressedSat == true {
            isPressedSat = false
            print("test")
            satButton.backgroundColor = .systemGray2
            return
        }
    }
    @IBAction func sunButtonAct(_ sender: Any) {
        if isPressedSun == false {
            isPressedSun = true
            sunButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
            return
        }
        if isPressedSun == true {
            isPressedSun = false
            print("test")
            sunButton.backgroundColor = .systemGray2
            return
        }
    }
    
//    @IBAction func saveActivity() {
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context: NSManagedObjectContext! = appDelegate.persistentContainer.viewContext
//
//        do {
//            self.updateActivity()
//            try context.save()
//        } catch let error {
//            print("Erro em ", error.localizedDescription)
//        }
//
//    }

    //ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.getActivityDetails()

        // Do any additional setup after loading the view.
    }
    //WillAppear
    override func viewWillAppear(_ animated: Bool) {
        //Colors
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        popupView.backgroundColor = .white
        
        //Labels
        actNameTextField.placeholder = actNameInfo
        nameLabel.font = .rounded(ofSize: 16, weight: .medium)
        timeLabel.font = .rounded(ofSize: 16, weight: .medium)
        starLabel.font = .rounded(ofSize: 16, weight: .medium)
        subActLabel.font = .rounded(ofSize: 16, weight: .medium)
        dayLabel.font = .rounded(ofSize: 16, weight: .medium)
        repeatLabel.font = .rounded(ofSize: 16, weight: .medium)
        
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
        weeklySwitch.onTintColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
        starSwitch.onTintColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
        
        //NavBar
        self.title = actNameInfo
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


}

//extension AllActFocusViewController {
//    func getActivityDetails() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context: NSManagedObjectContext! = appDelegate.persistentContainer.viewContext
//        let categoryActivities = NSPredicate(format: "%K == %@", #keyPath(Atividade.nome), self.actNameInfo as! CVarArg)
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Atividade")
//
//        request.predicate = categoryActivities
//
//        do {
//            let activitiesBank = try context.fetch(request)
//
//            if activitiesBank.count > 0 {
//                self.activity = activitiesBank[0] as! Atividade
//            } else {
//                // Alerta de Erro
//                print("Nenhuma atividade encontrada!")
//            }
//        } catch  let erro {
//            print("Erro ", erro.localizedDescription, " ao recuperar a atividade!")
//        }
//
//    }
//
//    func updateActivity() {
//        self.activity.setValue(self.actNameTextField.text!, forKey: "nome")
//        self.activity.setValue(self.imageButton.image(for: .normal)?.pngData(), forKey: "image")
//        self.activity.setValue(self.pickerView.date, forKey: "horario")
//        self.activity.setValue(self.isPressedMon, forKey: "segunda")
//        self.activity.setValue(self.isPressedTue, forKey: "terca")
//        self.activity.setValue(self.isPressedWed, forKey: "quarta")
//        self.activity.setValue(self.isPressedThu, forKey: "quinta")
//        self.activity.setValue(self.isPressedFri, forKey: "sexta")
//        self.activity.setValue(self.isPressedSat, forKey: "sabado")
//        self.activity.setValue(self.isPressedSun, forKey: "domingo")
//    }
//
//    func configureScreen() {
//        var photo: UIImage!
//
//        if let data = self.activity.image {
//            photo = UIImage(data: data)
//        } else {
//            photo = UIImage()
//        }
//
//        self.imageButton.setImage(photo, for: .normal)
//
//        self.pickerView.setDate(self.activity.horario ?? Date(), animated: false)
//
//        self.monButton.backgroundColor = self.activity.segunda ? #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1) : .systemGray2
//        self.tueButton.backgroundColor = self.activity.terca ? #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1) : .systemGray2
//        self.wedButton.backgroundColor = self.activity.quarta ? #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1) : .systemGray2
//        self.thuButton.backgroundColor = self.activity.quinta ? #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1) : .systemGray2
//        self.friButton.backgroundColor = self.activity.sexta ? #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1) : .systemGray2
//        self.satButton.backgroundColor = self.activity.sabado ? #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1) : .systemGray2
//        self.sunButton.backgroundColor = self.activity.domingo ? #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1) : .systemGray2
//
//        self.isPressedMon = self.activity.segunda
//        self.isPressedTue = self.activity.terca
//        self.isPressedWed = self.activity.quarta
//        self.isPressedThu = self.activity.quinta
//        self.isPressedFri = self.activity.sexta
//        self.isPressedSat = self.activity.sabado
//        self.isPressedSun = self.activity.domingo
//
//
//    }
//}
