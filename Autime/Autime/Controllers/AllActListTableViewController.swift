//
//  AllActListTableViewController.swift
//  Autime
//
//  Created by Luis Eduardo Ramos on 27/11/20.
//

import UIKit
import CoreData

// swiftlint:disable force_cast
// swiftlint:disable line_length
// swiftlint:disable trailing_whitespace
// swiftlint:disable vertical_whitespace

class AllActListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewFakeBar: UIView!
    
    //Variables
    var categoria: Int?
    var categoriaName: String!
    var weekDayName: String! = ""
    
    // MARK: - Garantir que a TV carregue a info do banco de dados
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
        //BackGround
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
        guard let allActFocus = storyboard?.instantiateViewController(identifier: "AllActFocusViewController") as? AllActFocusViewController else {
            return
        }
        allActFocus.weekDayName = self.weekDayName
        allActFocus.actNameInfo = self.activities[indexPath.row].nome ?? "Atividade Sem Nome"
        
        navigationController?.pushViewController(allActFocus, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AllActListTableViewController {
    
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
