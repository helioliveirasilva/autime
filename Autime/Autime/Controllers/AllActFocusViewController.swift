//
//  AllActFocusViewController.swift
//  Autime
//
//  Created by Luis Eduardo Ramos on 30/11/20.
//
// swiftlint:disable force_cast
// swiftlint:disable line_length
// swiftlint:disable trailing_whitespace
// swiftlint:disable vertical_whitespace

import UIKit
import CoreData

class AllActFocusViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
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
    @IBOutlet weak var subCollection: UICollectionView!
    
    //Variables
    var actNameInfo: String = "Erro"
    var isPressedMon: Bool = false
    var isPressedTue: Bool = false
    var isPressedWed: Bool = false
    var isPressedThu: Bool = false
    var isPressedFri: Bool = false
    var isPressedSat: Bool = false
    var isPressedSun: Bool = false
    var weekDayName: String! = ""
    var activity: Atividade! {
        didSet {
            self.configureScreen()
        }
    }
    var subAtividades: [SubAtividade] = [SubAtividade()] {
        didSet {
            self.subCollection.reloadData()
        }
    }
    var newSubs: [SubAtividade] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.subCollection.delegate = self
        self.subCollection.dataSource = self
        self.getActivityDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Colors
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        popupView.backgroundColor = .white
        
        //Labels
        actNameTextField.placeholder = "Nome da atividade"
        actNameTextField.text = actNameInfo
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
        
        self.getActivityDetails()
    }
    
    //Actions DailyButtons
    @IBAction func monButtonAction(_ sender: Any) {
        
        isPressedMon = !isPressedMon || self.weekDayName == "Segunda"
    
        if isPressedMon {
            monButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
        } else {
            monButton.backgroundColor = .systemGray2
        }
    }
    @IBAction func tueButtonAct(_ sender: Any) {
        isPressedTue = !isPressedTue || self.weekDayName == "Terça"
        
        if isPressedTue {
            tueButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
        } else {
            tueButton.backgroundColor = .systemGray2
        }
    }
    @IBAction func wedButtonAct(_ sender: Any) {
        isPressedWed = !isPressedWed || self.weekDayName == "Quarta"
        
        if isPressedWed {
            wedButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
        } else {
            wedButton.backgroundColor = .systemGray2
        }
    }
    @IBAction func thuButtonAct(_ sender: Any) {
        isPressedThu = !isPressedThu || self.weekDayName == "Quinta"
                
        if isPressedThu {
            thuButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
        } else {
            thuButton.backgroundColor = .systemGray2
        }
    }
    @IBAction func friButtonAct(_ sender: Any) {
        isPressedFri = !isPressedFri || self.weekDayName == "Sexta"
    
        if isPressedFri {
            friButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
        } else {
            friButton.backgroundColor = .systemGray2
        }
    }
    @IBAction func satButtonAct(_ sender: Any) {
        isPressedSat = !isPressedSat || self.weekDayName == "Sábado"
    
        if isPressedSat {
            satButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
        } else {
            satButton.backgroundColor = .systemGray2
        }
    }
    @IBAction func sunButtonAct(_ sender: Any) {
        isPressedSun = !isPressedSun || self.weekDayName == "Domingo"
        
        if isPressedSun {
            sunButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
        } else {
            sunButton.backgroundColor = .systemGray2
        }
    }
    
    @IBAction func saveActivity() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext! = appDelegate.persistentContainer.viewContext
        
        // Update and Save
        self.updateActivity()
                
        // Back to Day Table View
        if weekDayName != "" {
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: ThisWeekDayViewController.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func chooseImage() {
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

extension AllActFocusViewController {
    
    func getActivityDetails() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext! = appDelegate.persistentContainer.viewContext
        let categoryActivities = NSPredicate(format: "%K == %@", #keyPath(Atividade.nome), self.actNameInfo as! CVarArg)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Atividade")
        
        request.predicate = categoryActivities
        
        do {
            let activitiesBank = try context.fetch(request)
            
            if activitiesBank.count > 0 {
                self.activity = activitiesBank[0] as! Atividade
                self.getSubActivities()
            } else {
                // Alerta de Erro
                print("Nenhuma atividade encontrada!")
            }
        } catch  let erro {
            print("Erro ", erro.localizedDescription, " ao recuperar a atividade!")
        }
        
    }
    
    func getSubActivities() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let nameFilter = NSPredicate(format: "%K == %@", #keyPath(Atividade.nome), self.activity?.nome! as! CVarArg)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Atividade")
        request.predicate = nameFilter
        
        self.subAtividades.removeAll()
        
        do {
            let activitiesBank = try context.fetch(request)
            
            if activitiesBank.count > 0 {
                
                let activityResult = activitiesBank[0] as! Atividade
                
                for task in activityResult.passos! {
                    self.subAtividades.append(task as! SubAtividade)
                }
                            
            } else {
                print("Nenhuma atividade encontrada!")
            }
        } catch  let erro {
            print("Erro ", erro.localizedDescription, " ao recuperar a atividade!")
        }
        
        self.subAtividades.sort {
            $0.ordem < $1.ordem
        }
        
        // Botão de Add
        self.subAtividades.insert(SubAtividade(), at: 0)
        self.subCollection.reloadData()
        
    }
    
    func updateActivity() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        self.activity.setValue(self.actNameTextField.text!, forKey: "nome")
        self.activity.setValue(self.imageButton.image(for: .normal)?.pngData(), forKey: "image")
        self.activity.setValue(self.pickerView.date, forKey: "horario")
        self.activity.setValue(self.isPressedMon, forKey: "segunda")
        self.activity.setValue(self.isPressedTue, forKey: "terca")
        self.activity.setValue(self.isPressedWed, forKey: "quarta")
        self.activity.setValue(self.isPressedThu, forKey: "quinta")
        self.activity.setValue(self.isPressedFri, forKey: "sexta")
        self.activity.setValue(self.isPressedSat, forKey: "sabado")
        self.activity.setValue(self.isPressedSun, forKey: "domingo")
        
        for sub in newSubs {
            self.activity.addToPassos(sub)
        }
        
        do {
            try context.save()
            print("Seus dados foram salvos corretamente")
        } catch {
            print("Erro ao salvar os dados")
        }
    }
    
    func configureScreen() {
        var photo: UIImage!
        
        if let data = self.activity.image {
            photo = UIImage(data: data)
        } else {
            photo = UIImage()
        }
        
        self.imageButton.setImage(photo, for: .normal)
        
        self.pickerView.setDate(self.activity.horario ?? Date(), animated: false)
        
        self.isPressedMon = self.activity.segunda  || self.weekDayName == "Segunda"
        self.isPressedTue = self.activity.terca    || self.weekDayName == "Terça"
        self.isPressedWed = self.activity.quarta   || self.weekDayName == "Quarta"
        self.isPressedThu = self.activity.quinta   || self.weekDayName == "Quinta"
        self.isPressedFri = self.activity.sexta    || self.weekDayName == "Sexta"
        self.isPressedSat = self.activity.sabado   || self.weekDayName == "Sábado"
        self.isPressedSun = self.activity.domingo  || self.weekDayName == "Domingo"
                
        self.monButton.backgroundColor = self.isPressedMon ? #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1) : .systemGray2
        self.tueButton.backgroundColor = self.isPressedTue ? #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1) : .systemGray2
        self.wedButton.backgroundColor = self.isPressedWed ? #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1) : .systemGray2
        self.thuButton.backgroundColor = self.isPressedThu ? #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1) : .systemGray2
        self.friButton.backgroundColor = self.isPressedFri ? #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1) : .systemGray2
        self.satButton.backgroundColor = self.isPressedSat ? #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1) : .systemGray2
        self.sunButton.backgroundColor = self.isPressedSun ? #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1) : .systemGray2
        
    }
}

extension AllActFocusViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.subAtividades.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubAtividadeEditCell", for: indexPath) as! SubAtividadeCell
        
        if indexPath.item == 0 {
            cell.image = UIImage(systemName: "plus")
            return cell
        }
        
        var photo: UIImage!
        
        if let data = self.subAtividades[indexPath.item].image {
            photo = UIImage(data: data)
        } else {
            photo = UIImage()
        }
        
        cell.image = photo
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let viewCreatSubAct = UIStoryboard(name: "CadastrarAtividade", bundle: nil).instantiateViewController(withIdentifier: "CadastrarSubAtividade") as? CadastrarSubAtividadeViewController
        
            viewCreatSubAct?.modalPresentationStyle = .automatic
            viewCreatSubAct?.allActFocus = self
            self.present(viewCreatSubAct!, animated: true, completion: nil)
            
        }
    }
    
    func onUserAction(subAtividade: SubAtividade) {
        subAtividade.setValue(subAtividades.count, forKey: "ordem")
        subAtividades.append(subAtividade)
        newSubs.append(subAtividade)
        self.subCollection.reloadData()
    }
    
}
