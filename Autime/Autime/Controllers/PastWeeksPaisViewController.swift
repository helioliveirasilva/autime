//
//  PastWeeksPaisViewController.swift
//  Autime
//
//  Created by Luis Eduardo Ramos on 23/11/20.
//

import UIKit

class PastWeeksPaisViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewFakeBar: UIView!
    
    
    //Variables
    var semanasNovembro: [String] = ["22 a 28", "15 a 21", "08 a 14", "01 a 17"]
    var semanasOutubro: [String] = ["Em Breve"]
    var semanasSetembro: [String] = ["Em Breve"]
    var semanasAgosto: [String] = ["Em Breve"]
    var semanasJulho: [String] = ["Em Breve"]
    var semanasJunho: [String] = ["Em Breve"]
    var semanasMaio: [String] = ["Em Breve"]
    var semanasAbril: [String] = ["Em Breve"]
    var semanasMarço: [String] = ["Em Breve"]
    var semanasFevereiro: [String] = ["Em Breve"]
    var semanasJaneiro: [String] = ["Em Breve"]
    var semanasDezembro: [String] = ["Em Breve"]
    var meses: [String] = ["Novembro", "Outubro", "Setembro", "Agosto", "Julho", "Junho", "Maio", "Abril", "Março", "Fevereiro", "Janeiro", "Dezembro"]
    var semanasAnteriores: [String] = []
    //viewDidLoad
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
        //FakeNavBar
        self.viewFakeBar.layer.cornerRadius = 21
        viewFakeBar.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
        viewFakeBar.layer.shadowColor = UIColor.black.cgColor
        viewFakeBar.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        viewFakeBar.layer.shadowOpacity = 0.5
        viewFakeBar.layer.shadowRadius = 4.0
        
        //NavBar
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.rounded(ofSize: 22, weight: .bold)
        ]
    }
    // MARK: - Table view data source
    //Header TableView
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return meses[section]
    }
    //Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    //Header Customization
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //Font
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 20, y: 8, width: 500, height: 27)
        myLabel.font = UIFont.systemFont(ofSize: 12)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        myLabel.backgroundColor = .clear
        myLabel.textColor = .systemGray
        //Background
        let backLabel = UILabel()
        backLabel.frame = CGRect(x: 0, y: 0, width: 500, height: 35)
        backLabel.backgroundColor = .secondarySystemBackground
        //Add View
        let headerView = UIView()
        headerView.addSubview(backLabel)
        headerView.addSubview(myLabel)
        
        return headerView
    }
    //Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return meses.count
    }
    //Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            semanasAnteriores = semanasNovembro
        case 1:
            semanasAnteriores = semanasOutubro
        case 2:
            semanasAnteriores = semanasSetembro
        case 3:
            semanasAnteriores = semanasAgosto
        case 4:
            semanasAnteriores = semanasJulho
        case 5:
            semanasAnteriores = semanasJunho
        case 6:
            semanasAnteriores = semanasMaio
        case 7:
            semanasAnteriores = semanasAbril
        case 8:
            semanasAnteriores = semanasMarço
        case 9:
            semanasAnteriores = semanasFevereiro
        case 10:
            semanasAnteriores = semanasJaneiro
        case 11:
            semanasAnteriores = semanasDezembro
        default:
            semanasAnteriores = []
        }
        return semanasAnteriores.count
    }
    //Cell Config
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch indexPath.section {
        case 0:
            semanasAnteriores = semanasNovembro
        case 1:
            semanasAnteriores = semanasOutubro
        case 2:
            semanasAnteriores = semanasSetembro
        case 3:
            semanasAnteriores = semanasAgosto
        case 4:
            semanasAnteriores = semanasJulho
        case 5:
            semanasAnteriores = semanasJunho
        case 6:
            semanasAnteriores = semanasMaio
        case 7:
            semanasAnteriores = semanasAbril
        case 8:
            semanasAnteriores = semanasMarço
        case 9:
            semanasAnteriores = semanasFevereiro
        case 10:
            semanasAnteriores = semanasJaneiro
        case 11:
            semanasAnteriores = semanasDezembro
        default:
            semanasAnteriores = []
        }
        // Configure the cell...
        cell.textLabel?.text = String(semanasAnteriores[indexPath.row])
        return cell
    }
}
