//
//  ThisWeekDayViewController.swift
//  Autime
//
//  Created by Luis Eduardo Ramos on 07/12/20.
//

import UIKit

class ThisWeekDayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewFakeBar: UIView!
    @IBOutlet weak var viewButton: UIView!
    @IBOutlet weak var addButton: UIButton!
    
    //Variables
    var dayAct: [String] = ["Comer", "Estudar", "Terapia", "Correr"]
    var actTime: [String] = ["08:00", "09:00", "10:00", "11:00"]
    var weekDayName: String?
    let viewCreatAct = UIStoryboard(name: "PaisThisWeek", bundle: nil).instantiateViewController(withIdentifier: "ThisWeekCreatActViewController") as? ThisWeekCreatActViewController
    let viewAllAct = UIStoryboard(name: "PaisThisWeek", bundle: nil).instantiateViewController(withIdentifier: "ThisWeekCategoryViewController") as? ThisWeekCategoryViewController
    
    //DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .secondarySystemBackground
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
    
    //WillAppear
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
        
        
        
    }
    

    // MARK: - Table view data source
    //Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    //Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dayAct.count
    }
    //Cell Config
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = String(dayAct[indexPath.row])
        cell.textLabel?.font = .rounded(ofSize: 17, weight: .regular)
        cell.detailTextLabel?.text = String(actTime[indexPath.row])
        cell.detailTextLabel?.font = .rounded(ofSize: 17, weight: .regular)
        return cell
    }
    //Select ROw
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let thisweekFocus = storyboard?.instantiateViewController(identifier: "ThisWeekEditActViewController") as? ThisWeekEditActViewController else {
            return
        }
        thisweekFocus.actNameInfo = self.dayAct[indexPath.row]
        navigationController?.pushViewController(thisweekFocus, animated: true)
    }
    
    @IBAction func displayActionSheet(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: "Qual atividade?" , preferredStyle: .actionSheet)
        //Create Activity
        let creatAct = UIAlertAction(title: "Criar Nova", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
//            print("Seman Atual")
            self.navigationController?.pushViewController(self.viewCreatAct ?? ThisWeekCreatActViewController(), animated: true)
        })
        //All Activities
        let allAct = UIAlertAction(title: "Usar Cadastrada", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
//            print("Semanas Anteriores")
            self.navigationController?.pushViewController(self.viewAllAct ?? ThisWeekCategoryViewController(), animated: true)
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
