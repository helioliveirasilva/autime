//
//  ThisWeeksPaisViewController.swift
//  Autime
//
//  Created by Luis Eduardo Ramos on 23/11/20.
//

import UIKit

class ThisWeeksPaisViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    //Variables
    var diasDaSemana: [String] = ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta"]
    //ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .secondarySystemBackground
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //NavBar
        navigationController?.isNavigationBarHidden = false
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
        return diasDaSemana.count
    }
    //Cell Config
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = String(diasDaSemana[indexPath.row])
        cell.textLabel?.font = .rounded(ofSize: 17, weight: .regular)
        return cell
    }
}
