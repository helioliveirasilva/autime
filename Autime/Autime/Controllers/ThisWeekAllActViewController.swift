//
//  ThisWeekAllActViewController.swift
//  Autime
//
//  Created by Luis Eduardo Ramos on 08/12/20.
//

import UIKit
import CoreData

// swiftlint:disable force_cast
// swiftlint:disable line_length
// swiftlint:disable trailing_whitespace
// swiftlint:disable vertical_whitespace

class ThisWeekAllActViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewFakeBar: UIView!
    
    //Variables
    var categoria: Int?
    var categoriaName: String!
    var activities: [Atividade] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        self.getActivities()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Background
        self.view.backgroundColor = .secondarySystemBackground
        
        //NavBar
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = categoriaName
        
        //FakeNavBar
        self.viewFakeBar.layer.cornerRadius = 21
        viewFakeBar.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
        viewFakeBar.layer.shadowColor = UIColor.black.cgColor
        viewFakeBar.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        viewFakeBar.layer.shadowOpacity = 0.5
        viewFakeBar.layer.shadowRadius = 4.0
        
        self.getActivities()
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard categoria != nil else {
            return 0
        }
        return self.activities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "actCell", for: indexPath)

        guard categoria != nil else {
            //Retornar célula vazia
            return UITableViewCell()
        }
        // Configure the cell...
        cell.textLabel?.text = self.activities[indexPath.row].nome
        cell.textLabel?.font = .rounded(ofSize: 17, weight: .regular)

        return cell
    }
    //Selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let allActFocus = storyboard?.instantiateViewController(identifier: "ThisWeekAddFocusViewController") as? ThisWeekAddFocusViewController else {
            return
        }

        allActFocus.actNameInfo = self.activities[indexPath.row].nome ?? "Atividade Sem Nome"
        navigationController?.pushViewController(allActFocus, animated: true)
    }
}

extension ThisWeekAllActViewController {

    func getActivities() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let categoryActivities = NSPredicate(format: "%K == %@", #keyPath(Atividade.categoria), self.categoriaName as! CVarArg)
        let sortByName = NSSortDescriptor(key: "nome", ascending: true)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Atividade")

        request.sortDescriptors = [sortByName]
        request.predicate = categoryActivities

        do {
            let activitiesBank = try context.fetch(request)

            if activitiesBank.count > 0 {
                self.activities.removeAll()
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
