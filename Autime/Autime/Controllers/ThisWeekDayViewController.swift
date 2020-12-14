//
//  ThisWeekDayViewController.swift
//  Autime
//
//  Created by Luis Eduardo Ramos on 07/12/20.
//
// swiftlint:disable force_cast
// swiftlint:disable line_length
// swiftlint:disable trailing_whitespace
// swiftlint:disable vertical_whitespace

import UIKit
import CoreData

class ThisWeekDayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewFakeBar: UIView!
    @IBOutlet weak var viewButton: UIView!
    @IBOutlet weak var addButton: UIButton!
    
    //Variables
    var weekDayName: String!
    let viewCreatAct = UIStoryboard(name: "CadastrarAtividade", bundle: nil).instantiateViewController(withIdentifier: "CadastrarAtividade") as? AtividadesCadastradas
    let viewAllAct = UIStoryboard(name: "PaisAllAct", bundle: nil).instantiateViewController(withIdentifier: "AllActPaisViewController") as? AllActPaisViewController
    var activities: [Atividade] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .secondarySystemBackground
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //NavBar
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = weekDayName
        
        //FakeNavBar
        self.viewFakeBar.layer.cornerRadius = 21
        viewFakeBar.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
        viewFakeBar.layer.shadowColor = UIColor.black.cgColor
        viewFakeBar.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        viewFakeBar.layer.shadowOpacity = 0.5
        viewFakeBar.layer.shadowRadius = 4.0
        
        //ButtonView
        self.viewButton.layer.cornerRadius = 21
        viewButton.backgroundColor = .white
        viewButton.layer.shadowColor = UIColor.black.cgColor
        viewButton.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        viewButton.layer.shadowOpacity = 0.5
        viewButton.layer.shadowRadius = 4.0
        
        //Button
        self.addButton.layer.cornerRadius = 14
        self.addButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
        
        self.getActivities()
        self.tableView.reloadData()
    }
    

    // MARK: - Table view data source
    // Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.activities.count
    }
    
    // Cell Config
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let date = self.activities[indexPath.row].horario!
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        let formattedDate = format.string(from: date)

        cell.textLabel?.text = self.activities[indexPath.row].nome
        cell.textLabel?.font = .rounded(ofSize: 17, weight: .regular)
        cell.detailTextLabel?.text = formattedDate
        cell.detailTextLabel?.font = .rounded(ofSize: 17, weight: .regular)
        return cell
    }
    
    // Select Row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let thisweekFocus = storyboard?.instantiateViewController(identifier: "ThisWeekEditActViewController") as? ThisWeekEditActViewController else {
            return
        }
        thisweekFocus.actNameInfo = self.activities[indexPath.row].nome!
        thisweekFocus.weekDayName = self.weekDayName!
        navigationController?.pushViewController(thisweekFocus, animated: true)
    }
    
    @IBAction func displayActionSheet(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: "Qual atividade?", preferredStyle: .actionSheet)

        //Create Activity
        let creatAct = UIAlertAction(title: "Criar Nova", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in

            if self.weekDayName == "Domingo" {
                self.viewCreatAct?.pressSun = true
            } else if self.weekDayName == "Segunda" {
                self.viewCreatAct?.pressMon = true
            } else if self.weekDayName == "Terça" {
                self.viewCreatAct?.pressTue = true
            } else if self.weekDayName == "Quarta" {
                self.viewCreatAct?.pressWed = true
            } else if self.weekDayName == "Quinta" {
                self.viewCreatAct?.pressThu = true
            } else if self.weekDayName == "Sexta" {
                self.viewCreatAct?.pressFri = true
            } else if self.weekDayName == "Sábado" {
                self.viewCreatAct?.pressSat = true
            }
            
            self.viewCreatAct?.weekDayName = self.weekDayName
            self.navigationController?.pushViewController(self.viewCreatAct ?? AtividadesCadastradas(), animated: true)
        })

        //All Activities
        let allAct = UIAlertAction(title: "Usar Cadastrada", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in

            self.viewAllAct?.weekDayName = self.weekDayName
            self.navigationController?.pushViewController(self.viewAllAct ?? AllActPaisViewController(), animated: true)
        })
        
        //Cancel Button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
//            print("Canceled")
        })
        //Add actions on Action Sheet
        optionMenu.addAction(creatAct)
        optionMenu.addAction(allAct)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
}

extension ThisWeekDayViewController {
    
    func getActivities() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let sortByTime = NSSortDescriptor(key: "horario", ascending: true)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Atividade")
        
        request.sortDescriptors = [sortByTime]
        
        do {
            let activitiesBank = try context.fetch(request)
            var weekDay: Int {
                switch weekDayName {
                case "Domingo":
                    return 0
                case "Segunda":
                    return 1
                case "Terça":
                    return 2
                case "Quarta":
                    return 3
                case "Quinta":
                    return 4
                case "Sexta":
                    return 5
                case "Sábado":
                    return 6
                default:
                    return 0
                }
            }

            if activitiesBank.count > 0 {
                self.activities.removeAll()
                
                for activity in activitiesBank as! [NSManagedObject] {
                    
                    let act = activity as! Atividade
                    
                    let diasSemana = [
                        act.domingo,
                        act.segunda,
                        act.terca,
                        act.quarta,
                        act.quinta,
                        act.sexta,
                        act.sabado
                    ]
                    
                    if diasSemana[weekDay] {
                        self.activities.append(act)
                    }
                    
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
