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

class SubTarefasViewController: UIViewController {
    @IBOutlet var subtarefasCollection: UICollectionView!
    @IBOutlet weak var botaoconcluir: UIButton!
    @IBOutlet weak var barraProgresso: UIProgressView!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var icone: UIImageView!
    
    var imagemIconce: UIImage!
    var tituloAtividade: String!
    var feedback: FeedbackChildView!
    var dayView: DayViewController?
    
    var isPremio: Bool!
    var progresso: Float = 0
    var activity: Atividade?
    var subActivities: [SubAtividade]! = [] {
        didSet {
            checado.removeAll()
            for sub in subActivities {
                checado.append(!sub.completa)
            }
        
            subtarefasCollection.reloadData()
        }
    }
    var checado: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.icone.image = imagemIconce
        tituloLabel.text = tituloAtividade
        tituloLabel.font = .rounded(ofSize: 25, weight: .bold)
        
        botaoconcluir.layer.cornerRadius = botaoconcluir.frame.height/3
        botaoconcluir.titleLabel?.font = .rounded(ofSize: 15, weight: .bold)
        botaoconcluir.setTitleColor(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .disabled)
        botaoconcluir.setTitleColor(.white, for: .normal)

        self.feedback = FeedbackChildView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        self.view.addSubview(feedback)
        self.feedback.isHidden = true
        
        subtarefasCollection.delegate = self
        subtarefasCollection.dataSource = self
        
        self.getSubActivities()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        let complete = checado.filter { !$0 }
        let subs = subActivities.count
        progresso = subs > 0 ? Float(complete.count)/Float(subs) : 1.0
        
//        print("Complete.count: ", Float(complete.count))
//        print("Subs.count: ", subs)
//
//        print("Complete: ", complete.count)
//        print("Progresso ", progresso)
        
        barraProgresso.setProgress(progresso, animated: false)
        
        if progresso == 1.0 {
            botaoconcluir.isEnabled = true
            botaoconcluir.backgroundColor = #colorLiteral(red: 0.4371337295, green: 0.8646664619, blue: 0.4942504764, alpha: 1)

        } else {
            botaoconcluir.isEnabled = false
            botaoconcluir.backgroundColor = #colorLiteral(red: 0.7498548031, green: 0.7448977828, blue: 0.749243319, alpha: 1)
        }
        
        subtarefasCollection.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            try context.save()
        } catch let error {
            print("Erro ", error.localizedDescription, " no salvamento das subatividades.")
        }
    
    }
    
    @IBAction func concluir(_ sender: Any) {
        self.feedback.isHidden = false

        var arrayPremio = dayView?.arrayPremio
        
        if isPremio == true {
            
            if arrayPremio![0] == false {
                arrayPremio![0] = true
            } else if arrayPremio![1] == false {
                arrayPremio![1] = true
            } else if arrayPremio![2] == false {
                arrayPremio![2] = true
            }
            
            print(arrayPremio!)
        }
        
        dayView?.onUserAction(array: arrayPremio!)
        activity?.setValue(true, forKey: "completa")
    }
}

extension SubTarefasViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.subActivities.count
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
        
        // sombra e arredondamento
        cell.mainView.layer.cornerRadius = 21
        cell.mainView.layer.shadowColor = UIColor.black.cgColor
        cell.mainView.layer.shadowOpacity = 0.2
        cell.mainView.layer.shadowOffset = .zero
        cell.mainView.layer.shadowRadius = 15
        cell.image.roundCorners(corners: [.topLeft, .topRight], radius: 21)
        cell.imagecheck.roundCorners(corners: [.topLeft, .topRight], radius: 21)
        
        cell.image.image = photo
        cell.label.text = self.subActivities[indexPath.item].nome
        cell.label.font = .rounded(ofSize: 15, weight: .medium)
        cell.imagecheck.isHidden = checado[indexPath.item]
        
        return cell
    }
    
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = subtarefasCollection.cellForItem(at: indexPath) as! SubtarefasCollectionCell

        if indexPath.item == 0 {
            
            if checado[indexPath.item] == true {
                checado[indexPath.item] = false
                progresso = Float(indexPath.item+1)/Float(self.subActivities.count)
                barraProgresso.setProgress(progresso, animated: true)
            } else {
                progresso = Float(indexPath.item)/Float(self.subActivities.count)
                barraProgresso.setProgress(progresso, animated: true)

                for che in indexPath.item...checado.count-1 {
                    checado[che] = true
                }
            }
            
        } else if checado[indexPath.item-1] == false {
            
            if checado[indexPath.item] == true {
                checado[indexPath.item] = false
                progresso = Float(indexPath.item+1)/Float(self.subActivities.count)
                barraProgresso.setProgress(progresso, animated: true)

            } else {
                progresso = Float(indexPath.item)/Float(self.subActivities.count)
                barraProgresso.setProgress(progresso, animated: true)
                for che in indexPath.item...checado.count-1 {
                    checado[che] = true
                }
            }
            
        }
        
        for (index, check) in checado.enumerated() {
            self.subActivities[index].setValue(!check, forKey: "completa")
        }
        
        if progresso == 1.0 {
            botaoconcluir.isEnabled = true
            botaoconcluir.backgroundColor = #colorLiteral(red: 0.4371337295, green: 0.8646664619, blue: 0.4942504764, alpha: 1)
        } else {
            botaoconcluir.isEnabled = false
            botaoconcluir.backgroundColor = #colorLiteral(red: 0.7498548031, green: 0.7448977828, blue: 0.749243319, alpha: 1)
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
