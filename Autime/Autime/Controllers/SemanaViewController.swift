//
//  SemanaViewController.swift
//  Autime
//
//  Created by Victor Vieira on 26/11/20.
//

// swiftlint:disable force_cast
// swiftlint:disable line_length
// swiftlint:disable trailing_whitespace
// swiftlint:disable vertical_whitespace
// swiftlint:disable weak_delegate
// swiftlint:disable opening_brace
// swiftlint:disable colon

import UIKit
import CoreData

class SemanaViewController: UIViewController {
    
    var activities: [Atividade] = []
    var diasSemana: [[Bool]] = []
    var atividadesSemana: [AtividadesSemana] = []
    @IBOutlet var collectionView: UICollectionView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        getActivites()
        collectionView.delegate = self
        collectionView.dataSource = self
        
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

extension SemanaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        atividadesSemana.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        atividadesSemana[section].atividades.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "datatag", for: indexPath) as! SectionHeaderView
        let day = atividadesSemana[indexPath.section]
        sectionHeaderView.dataText = day.title
        
        return sectionHeaderView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "semanacell", for: indexPath) as! SemanaCollectionViewCell
        let dia = atividadesSemana[indexPath.section]
        
        var photo: UIImage!
        
        if let data = dia.atividades[indexPath.item].image {
            photo = UIImage(data: data)
        } else {
            photo = UIImage()
        }
        
        cell.image.image = photo
        
        return cell
    }
}


extension SemanaViewController {
    
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
                
                setWeek()
                
            } else {
                print("Nenhuma atividade encontrada!")
            }
        } catch  let erro {
            print("Erro ", erro.localizedDescription, " ao recuperar a atividade!")
        }
    }
    
    func setWeek(){
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd/MM"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        let calendar = Calendar.current
        print(calendar.component(.weekday, from: date))
        var dias: [Date] = []
        
        for activity in activities {
            
            diasSemana.append([activity.domingo,
                               activity.segunda,
                               activity.terca,
                               activity.quarta,
                               activity.quinta,
                               activity.sexta,
                               activity.sabado
            ])
        }
        
        for ind in 0...6 {
            dias.append(addNumberOfDaysToDate(date: date, count: ind))
        }
        
        for dia in dias {
            let weekDay = calendar.component(.weekday, from: dia) - 1
            var atvs: [Atividade] = []
            for activity in activities {
                let week = [
                    activity.domingo,
                    activity.segunda,
                    activity.terca,
                    activity.quarta,
                    activity.quinta,
                    activity.sexta,
                    activity.sabado
                ]
                
                if week[weekDay] {
                    atvs.append(activity)
                }
                
            }
            let formattedData = format.string(from: dia)
            atividadesSemana.append(AtividadesSemana(data: dia, title: formattedData, atividades: atvs))
        }
    }
    
    func addNumberOfDaysToDate(date: Date, count: Int) -> Date{
        let newComponent = DateComponents(day: count)
        guard let newDate = Calendar.current.date(byAdding: newComponent, to: date) else {
            return date
        }
        return newDate
    }
}

struct PhotoDays {
    var photoDay: String
    var title: String
    var images: [String]
    
}

struct AtividadesSemana {
    let data: Date
    let title: String
    let atividades: [Atividade]
}
