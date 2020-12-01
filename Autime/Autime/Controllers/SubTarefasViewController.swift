//
//  SubTarefasViewController.swift
//  Autime
//
//  Created by Victor Vieira on 19/11/20.
//

import UIKit
import CoreData

class SubTarefasViewController: UIViewController {
    
    // swiftlint:disable force_cast
    // swiftlint:disable line_length
    // swiftlint:disable trailing_whitespace
    // swiftlint:disable vertical_whitespace
    
    @IBOutlet var subtarefasCollection: UICollectionView!
    
    var imagens: [UIImage] = [UIImage(named: "test")!,UIImage(named: "test")!,UIImage(named: "test")!,UIImage(named: "test")!,UIImage(named: "test")!,UIImage(named: "test")!]
    
    var subActivities: [SubAtividade]! = []
    var activity: Atividade?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subtarefasCollection.delegate = self
        subtarefasCollection.dataSource = self
        
        self.getSubActivities()
        
        // Do any additional setup after loading the view.
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

extension SubTarefasViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.subActivities!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subcell", for: indexPath as IndexPath) as? SubtarefasCollectionCell else {
            print("ERROOOU!")
            fatalError()}
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "my cell", for: indexPath as IndexPath) as! FilhoCollectionViewCell

        // Image
        var photo: UIImage!
              
        if let data = self.subActivities[indexPath.item].image {
            photo = UIImage(data: data)
        } else {
            photo = UIImage()
        }
        cell.layer.cornerRadius = 21
        cell.image.image = photo
        cell.label.text = self.subActivities[indexPath.item].nome

        return cell
    }
    
    
    
}

extension SubTarefasViewController {
    func getSubActivities() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let nameFilter = NSPredicate(format: "%K == %@", #keyPath(Atividade.nome), self.activity?.nome! as! CVarArg)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Atividade")
        request.predicate = nameFilter
        
        self.subActivities!.removeAll()
        
        do {
            let activitiesBank = try context.fetch(request)
            
            if activitiesBank.count > 0 {
                
                let activityResult = activitiesBank[0] as! Atividade

                for task in activityResult.passos! {
                    self.subActivities!.append(task as! SubAtividade)
                }
                            
            } else {
                print("Nenhuma atividade encontrada!")
            }
        } catch  let erro {
            print("Erro ", erro.localizedDescription, " ao recuperar a atividade!")
        }
        
        self.subActivities.sort {
            $0.ordem < $1.ordem
        }
        
        self.subtarefasCollection.reloadData()
        
    }
}
