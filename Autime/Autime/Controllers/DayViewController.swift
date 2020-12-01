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
    
    var imagens: [UIImage] = [UIImage(named: "test.png")!, UIImage(named: "test1.jpeg")!, UIImage(named: "test2.jpeg")!, UIImage(named: "test3.jpg")!, UIImage(named: "test4.jpg")!, UIImage(named: "test5.jpg")!]
    var nomes: [String] = ["Café da manhã", "Tomar banho", "Escola", "Psicóloga", "Passear com o cachorro", "Tarefa de casa"]
    var activities: [Atividade] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tarefasCollection.delegate = self
        tarefasCollection.dataSource = self
        
        self.navigationController?.navigationBar.isHidden = false
        self.getActivites()
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
        return self.activities.count
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
              
        if let data = self.activities[indexPath.item].image {
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
        let newDate = dateFormatter.string(from: self.activities[indexPath.item].horario!)
        
        cell.hora.text =  newDate
        cell.atividade.text = self.activities[indexPath.item].nome ?? "Sem nome"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let subtarefaStoryboard = UIStoryboard(name: "SubTarefas", bundle: nil)
        let subtarefaView = (subtarefaStoryboard.instantiateViewController(withIdentifier: "subtarefa")) as? SubTarefasViewController
        
        subtarefaView?.activity = self.activities[indexPath.item]
        
        // subtarefaView.navigationController?.navigationBar.isHidden = false
        self.navigationController?.present(subtarefaView ?? UIViewController(), animated: true, completion: nil)
        
    }
    
}

extension DayViewController {
    
    func getActivites() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //let todayActivities = NSPredicate(format: "%K <= %@", #keyPath(Atividade.horario), Calendar.current.dateComponents([.day], from: Date()) as CVarArg)
        let sortByTime = NSSortDescriptor(key: "horario", ascending: true)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Atividade")
        
        request.sortDescriptors = [sortByTime]
        //request.predicate = todayActivities
        
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
    
}
