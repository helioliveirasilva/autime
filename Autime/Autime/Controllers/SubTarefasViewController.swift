//
//  SubTarefasViewController.swift
//  Autime
//
//  Created by Victor Vieira on 19/11/20.
//
// swiftlint:disable force_cast
// swiftlint:disable line_length
// swiftlint:disable trailing_whitespace
// swiftlint:disable vertical_whitespace
import UIKit
import CoreData

var titulos: [String] = ["Casa", "Sapato", "Perna", "Bilola", "Panela", "Bacia", "1", "1", "1"]
var checado: [Bool] = [true, true, true, true, true, true, true, true, true]
var progresso: Float = 0

class SubTarefasViewController: UIViewController {
    @IBOutlet var subtarefasCollection: UICollectionView!
    @IBOutlet weak var botaoconcluir: UIButton!
    @IBOutlet weak var barraProgresso: UIProgressView!
    var feedback: FeedbackChildView!

    var imagens: [UIImage] = [UIImage(named: "test")!,UIImage(named: "test")!,UIImage(named: "test")!,UIImage(named: "test")!,UIImage(named: "test")!,UIImage(named: "test")!]
    
    var activity: Atividade?

    var subActivities: [SubAtividade]! = [] {
        didSet {
            subtarefasCollection.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.feedback = FeedbackChildView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        self.view.addSubview(feedback)
        self.feedback.isHidden = true
        
        subtarefasCollection.delegate = self
        subtarefasCollection.dataSource = self
        
        self.getSubActivities()
        
        if checado.last == false {
            botaoconcluir.isEnabled = true
            botaoconcluir.backgroundColor = .green
        } else {
            botaoconcluir.isEnabled = false
            botaoconcluir.backgroundColor = .gray
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        barraProgresso.setProgress(progresso, animated: false)
        subtarefasCollection.reloadData()
    }
    
    @IBAction func concluir(_ sender: Any) {
        self.feedback.isHidden = false
        // self.dismiss(animated: true, completion: nil)
    }
    

}

extension SubTarefasViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    override func didReceiveMemoryWarning() {
        // Salvar contexto da sub Atividade
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        checado.count
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
        cell.label.text = titulos[indexPath.item]
        cell.imagecheck.isHidden = checado[indexPath.item]
        
        

        return cell
    }
    
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = subtarefasCollection.cellForItem(at: indexPath) as! SubtarefasCollectionCell

        if indexPath.item == 0 {
            
            if checado[indexPath.item] == true {
                checado[indexPath.item] = false
                progresso = Float(indexPath.item+1)/Float(titulos.count)
                barraProgresso.setProgress(progresso, animated: true)
            } else {
                progresso = Float(indexPath.item)/Float(titulos.count)
                barraProgresso.setProgress(progresso, animated: true)

                for che in indexPath.item...checado.count-1 {
                    checado[che] = true
                }
            }
            
        } else if checado[indexPath.item-1] == false {
            
            if checado[indexPath.item] == true {
                checado[indexPath.item] = false
                progresso = Float(indexPath.item+1)/Float(titulos.count)
                barraProgresso.setProgress(progresso, animated: true)

            } else {
                progresso = Float(indexPath.item)/Float(titulos.count)
                barraProgresso.setProgress(progresso, animated: true)
                for che in indexPath.item...checado.count-1 {
                    checado[che] = true
                }
            }
            
        }
        
        if checado.last == false {
            botaoconcluir.isEnabled = true
            botaoconcluir.backgroundColor = .green
        } else {
            botaoconcluir.isEnabled = false
            botaoconcluir.backgroundColor = .gray
        }

        subtarefasCollection.reloadData()
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
