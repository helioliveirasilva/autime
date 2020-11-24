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
    @IBOutlet weak var createActivity: UIButton!
    
    var imagens: [UIImage] = [UIImage(named: "test.png")!, UIImage(named: "test1.jpeg")!, UIImage(named: "test2.jpeg")!, UIImage(named: "test3.jpg")!, UIImage(named: "test4.jpg")!, UIImage(named: "test5.jpg")!]
    var nomes: [String] = ["Café da manhã", "Tomar banho", "Escola", "Psicóloga", "Passear com o cachorro", "Tarefa de casa"]
    var activities: [Activity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tarefasCollection.delegate = self
        tarefasCollection.dataSource = self
        
        self.navigationController?.navigationBar.isHidden = false
        self.getActivites()
    }
    
    @IBAction func touchCreateActivity() {
        self.createActivities()
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
        
        
        
        if let image = activities[indexPath.item].photo.toData() as UIImage {
            cell.imageView.image = image

        } else {
            cell.imageView.image = imagens[0]
        }
            
    
        // Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        let newDate = dateFormatter.string(from: activities[indexPath.item].time!)
        
        cell.hora.text =  newDate
        cell.atividade.text = activities[indexPath.item].name ?? "Sem nome"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let subtarefaStoryboard = UIStoryboard(name: "SubTarefas", bundle: nil)
        let subtarefaView = (subtarefaStoryboard.instantiateViewController(withIdentifier: "subtarefa")) as? SubTarefasViewController
        
        
        // subtarefaView.navigationController?.navigationBar.isHidden = false
        self.navigationController?.present(subtarefaView ?? UIViewController(), animated: true, completion: nil)
        
    }
    
    
}

extension DayViewController {
    
    func getActivites() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
        
        do {
            let activitiesBank = try context.fetch(request)
            
            if activitiesBank.count > 0 {
                self.activities = []
                for activity in activitiesBank as! [NSManagedObject] {
                    self.activities.append(activity as! Activity)
                }
                
            } else {
                print("Nenhuma atividade encontrada!")
            }
        } catch  let erro {
            print("Erro ", erro.localizedDescription, " ao recuperar a atividade!")
        }
    }
    
    func createActivities() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let activity = NSEntityDescription.insertNewObject(forEntityName: "Activity", into: context)
        
        let name = self.nomes.randomElement()!
        let image = self.imagens.randomElement()!.toData as! NSData

        let date = Date(timeIntervalSinceNow: 0)
        
        activity.setValue(name, forKey: "name")
        activity.setValue(date, forKey: "time")
        activity.setValue(image, forKey: "photo")
        
        // Salvar/Persistir os dados
        do {
            try context.save()
            print("Seus dados foram salvos corretamente!")
        } catch {
            print("Erro ao salvar os dados...")
        }
        
        getActivites()
        self.tarefasCollection.reloadData()
        
    }
    
}

extension UIImage {
    
    var toData: Data? {
        return pngData()
    }
}