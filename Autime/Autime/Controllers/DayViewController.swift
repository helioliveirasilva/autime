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
    
    @IBOutlet var tarefasCollection: UICollectionView!
    
    var activities: [Atividade] = []
    var todayActivities: [Atividade] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getActivites()
        self.getTodayActivities()
        
        tarefasCollection.delegate = self
        tarefasCollection.dataSource = self
        
        self.navigationController?.navigationBar.isHidden = false
        
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
        cell.layer.cornerRadius = 21

        // Image
        var photo: UIImage!
              
        if let data = self.todayActivities[indexPath.item].image {
            photo = UIImage(data: data)
        } else {
            photo = UIImage()
        }
        
        cell.imageView.image = photo
    
        // Fontes
        cell.hora.font = .rounded(ofSize: 16, weight: .heavy)
        cell.atividade.font = .rounded(ofSize: 20, weight: .medium)
        cell.subTarefas.font = .rounded(ofSize: 15, weight: .medium)
        
        // Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let newDate = dateFormatter.string(from: self.todayActivities[indexPath.item].horario!)
        
        cell.hora.text =  newDate
        cell.atividade.text = self.todayActivities[indexPath.item].nome ?? "Sem nome"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let subtarefaStoryboard = UIStoryboard(name: "SubTarefas", bundle: nil)
        let subtarefaView = (subtarefaStoryboard.instantiateViewController(withIdentifier: "subtarefa")) as? SubTarefasViewController
        
        subtarefaView?.activity = self.todayActivities[indexPath.item]
        
        // subtarefaView.navigationController?.navigationBar.isHidden = false
        self.navigationController?.present(subtarefaView ?? UIViewController(), animated: true, completion: nil)
        
    }
    
}

extension DayViewController {
    
    func getActivites() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let sortByTime = NSSortDescriptor(key: "horario", ascending: true)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Atividade")
        
        request.sortDescriptors = [sortByTime]
        
        do {
            let activitiesBank = try context.fetch(request)
            
            if activitiesBank.count > 0 {
                self.activities = []
                for activity in activitiesBank as! [NSManagedObject] {
                    self.activities.append(activity as! Atividade)
                }
                
            } else {
                print("Nenhuma atividade encontrada!")
            }
        } catch  let erro {
            print("Erro ", erro.localizedDescription, " ao recuperar a atividade!")
        }
    }
    
    func getTodayActivities() {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd/MM"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        let calendar = Calendar.current
        let weekDay = calendar.component(.weekday, from: date) - 1
        
        for activity in activities {
           let diasSemana = [activity.domingo,
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
