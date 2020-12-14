//
//  DayViewController.swift
//  Autime
//
//  Created by Victor Vieira on 19/11/20.
//

import UIKit
import CoreData

// swiftlint:disable force_cast
// swiftlint:disable line_length
// swiftlint:disable trailing_whitespace
// swiftlint:disable vertical_whitespace

class DayViewController: UIViewController {
    
    var categorias: [String] = ["Domésticas", "Higiene", "Educação", "Saúde", "Família", "Amigos", "Alimentação", "Entreterimento", "Prêmio", "Extras"]
    
    var catImages: [String] = ["CatDomestic", "CatHygiene", "CatEducation", "CatHealth", "CatFamily", "CatFriends", "CatFood", "CatEntertainment", "CatPrize", "CatExtras"]
    
    @IBOutlet var tarefasCollection: UICollectionView!
    @IBOutlet weak var premioView: UIView!
    @IBOutlet weak var premioStar1: UIImageView!
    @IBOutlet weak var premioStar2: UIImageView!
    @IBOutlet weak var premioStar3: UIImageView!
    @IBOutlet weak var labelAtividadePremio: UILabel!
    @IBOutlet weak var labelDescricao: UILabel!
    @IBOutlet weak var labelNExiste: UILabel!
    
    var arrayPremio: [Bool] = [false, false, false]
    var todayActivities: [Atividade] = [] {
        didSet {
            tarefasCollection.reloadData()
        }
    }
    var activities: [Atividade] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getTodayActivities()
        
        // Premio View
        premioView.roundCorners(corners: [.topLeft, .topRight], radius: 21)
        premioView.layer.shadowColor = UIColor.black.cgColor
        premioView.layer.shadowOpacity = 1
        premioView.layer.shadowOffset = CGSize(width: 50, height: 50)
        premioView.layer.shadowRadius = 50
        labelAtividadePremio.font = .rounded(ofSize: 19, weight: .bold)
        labelNExiste.font = .rounded(ofSize: 16, weight: .bold)
        labelNExiste.isHidden = true
        labelDescricao.font = .rounded(ofSize: 14, weight: .bold)
        
        tarefasCollection.delegate = self
        tarefasCollection.dataSource = self
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if arrayPremio[0] == true {
            premioStar1.tintColor = #colorLiteral(red: 0.9717512727, green: 0.6489240527, blue: 0.08678742498, alpha: 1)
        }
        if arrayPremio[1] == true {
            premioStar2.tintColor = #colorLiteral(red: 0.9717512727, green: 0.6489240527, blue: 0.08678742498, alpha: 1)
        }
        if arrayPremio[2] == true {
            premioStar3.tintColor = #colorLiteral(red: 0.9717512727, green: 0.6489240527, blue: 0.08678742498, alpha: 1)
        }
        
        self.getTodayActivities()
        print(todayActivities)
        self.tarefasCollection.reloadData()
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension DayViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.todayActivities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "my cell", for: indexPath as IndexPath) as? FilhoCollectionViewCell else {
            print("Erro ao criar a célula")
            fatalError()
        }
        
        // Views
        cell.backhourView.layer.cornerRadius = 15
        cell.mainActView.layer.cornerRadius = 21
        
        // Sombra
        
        cell.mainActView.layer.shadowColor = UIColor.black.cgColor
        cell.mainActView.layer.shadowOpacity = 0.1
        cell.mainActView.layer.shadowOffset = CGSize(width: 5, height: 5)
        cell.mainActView.layer.shadowRadius = 15
        cell.imageView.roundCorners(corners: [.topLeft, .topRight], radius: 21)
        
        // Image
        var photo: UIImage!
        
        if let data = self.todayActivities[indexPath.item].image {
            photo = UIImage(data: data)
        } else {
            photo = UIImage()
        }
        
        cell.imageView.image = photo
        
        // Icone
        let indice = categorias.firstIndex(of: self.todayActivities[indexPath.item].categoria ?? "erro")!
        cell.iconActivity.image = UIImage(named: catImages[indice])
        
        // Fontes
        cell.hora.font = .rounded(ofSize: 16, weight: .heavy)
        cell.atividade.font = .rounded(ofSize: 20, weight: .bold)
        cell.subTarefas.font = .rounded(ofSize: 15, weight: .bold)
        
        // Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let newDate = dateFormatter.string(from: self.todayActivities[indexPath.item].horario!)
        
        cell.hora.text =  newDate
        cell.atividade.text = (self.todayActivities[indexPath.item].nome ?? "Sem nome").capitalizingFirstLetter()
        cell.subTarefas.text = String(self.todayActivities[indexPath.item].passos!.count) + " subtarefas"
        
        // Check
        cell.checkImage.isHidden = !self.todayActivities[indexPath.item].completa
        cell.checkImage.roundCorners(corners: [.topLeft, .topRight], radius: 21)

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let subtarefaStoryboard = UIStoryboard(name: "SubTarefas", bundle: nil)
        let subtarefaView = (subtarefaStoryboard.instantiateViewController(withIdentifier: "subtarefa")) as? SubTarefasViewController
        
        subtarefaView?.activity = self.todayActivities[indexPath.item]
        
        subtarefaView?.tituloAtividade = (self.todayActivities[indexPath.item].nome ?? "Sem nome").capitalizingFirstLetter()
        
        let indice = categorias.firstIndex(of: self.todayActivities[indexPath.item].categoria ?? "erro")!
        subtarefaView?.imagemIconce = UIImage(named: catImages[indice])
        
        subtarefaView?.isPremio = self.todayActivities[indexPath.item].gerarEstrela
        subtarefaView?.dayView = self
        
        // subtarefaView.navigationController?.navigationBar.isHidden = false
        self.navigationController?.present(subtarefaView ?? UIViewController(), animated: true, completion: nil)
        
    }
    
    func onUserAction(array: [Bool]) {
        arrayPremio = array
        
        if arrayPremio[0] == true {
            premioStar1.tintColor = #colorLiteral(red: 0.9717512727, green: 0.6489240527, blue: 0.08678742498, alpha: 1)
        }
        if arrayPremio[1] == true {
            premioStar2.tintColor = #colorLiteral(red: 0.9717512727, green: 0.6489240527, blue: 0.08678742498, alpha: 1)
        }
        if arrayPremio[2] == true {
            premioStar3.tintColor = #colorLiteral(red: 0.9717512727, green: 0.6489240527, blue: 0.08678742498, alpha: 1)
        }
        
    }
    
}

extension DayViewController {
    
    func getActivities() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let sortByTime = NSSortDescriptor(key: "horario", ascending: true)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Atividade")
        
        request.sortDescriptors = [sortByTime]
        
        do {
            let activitiesBank = try context.fetch(request)
            
            if activitiesBank.count > 0 {
                self.activities.removeAll()
                for activity in activitiesBank as! [NSManagedObject] {
                    self.activities.append(activity as! Atividade)
                }
                
                self.activities.sort {
                    let date0 = $0.horario!
                    let date1 = $1.horario!
                    
                    let format = DateFormatter()
                    format.dateFormat = "HH:mm"
                    
                    let formattedDate0 = format.string(from: date0)
                    let formattedDate1 = format.string(from: date1)
                    
                    return formattedDate0 < formattedDate1
                }
                
            } else {
                print("Nenhuma atividade encontrada!")
            }
        } catch  let erro {
            print("Erro ", erro.localizedDescription, " ao recuperar a atividade!")
        }
    }
    
    func getTodayActivities() {
        self.getActivities()
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd/MM"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        let calendar = Calendar.current
        let weekDay = calendar.component(.weekday, from: date) - 1
        
        for activity in activities {
            let diasSemana = [
                activity.domingo,
                activity.segunda,
                activity.terca,
                activity.quarta,
                activity.quinta,
                activity.sexta,
                activity.sabado
            ]
            
            if diasSemana[weekDay] {
                todayActivities.append(activity)
            }
        }
    }
    
}
