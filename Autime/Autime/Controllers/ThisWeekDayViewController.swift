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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .secondarySystemBackground
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
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
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let thisweekFocus = storyboard?.instantiateViewController(identifier: "ThisWeekEditActViewController") as? ThisWeekEditActViewController else {
            return
        }
        thisweekFocus.actNameInfo = self.dayAct[indexPath.row] ?? "Atividade Sem Nome"
        navigationController?.pushViewController(thisweekFocus, animated: true)
    }
}
