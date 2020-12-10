//
//  AllActCategoriesTableViewController.swift
//  Autime
//
//  Created by Luis Eduardo Ramos on 24/11/20.
//
// swiftlint:disable force_cast
// swiftlint:disable line_length
// swiftlint:disable trailing_whitespace
// swiftlint:disable vertical_whitespace
import UIKit

class AllActPaisViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewFakeBar: UIView!
    
    //Variables
    var categorias: [String] = ["Domésticas", "Higiene", "Educação", "Saúde", "Família", "Amigos", "Alimentação", "Entreterimento", "Prêmio", "Extras"]
    var catImages: [String] = ["CatDomestic", "CatHygiene", "CatEducation", "CatHealth", "CatFamily", "CatFriends", "CatFood", "CatEntertainment", "CatPrize", "CatExtras"]
    var weekDayName: String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Background
        self.view.backgroundColor = .secondarySystemBackground
        
        //NavBar
        navigationController?.isNavigationBarHidden = false
        
        //FakeNavBar
        self.viewFakeBar.layer.cornerRadius = 21
        viewFakeBar.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
        viewFakeBar.layer.shadowColor = UIColor.black.cgColor
        viewFakeBar.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        viewFakeBar.layer.shadowOpacity = 0.5
        viewFakeBar.layer.shadowRadius = 4.0
    }
    
    // MARK: - Table view data source
    
    // Header TableView
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "CATEGORIAS"
    }
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    // Header Customization
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //Font
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 20, y: 8, width: 500, height: 27)
        myLabel.font = .rounded(ofSize: 12, weight: .regular)
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
    
    // Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categorias.count
    }
    
    // Cell Config
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = String(categorias[indexPath.row])
        cell.imageView?.image = UIImage(named: catImages[indexPath.row])
        cell.textLabel?.font = .rounded(ofSize: 17, weight: .regular)
        return cell
    }
    
    // Selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let allActList = storyboard?.instantiateViewController(identifier: "AllActListTableViewController") as? AllActListTableViewController else {
            return
        }
        switch indexPath.row {
        case 0 :
            allActList.categoria = indexPath.row
            allActList.categoriaName = categorias[indexPath.row]
        case 1:
            allActList.categoria = indexPath.row
            allActList.categoriaName = categorias[indexPath.row]
        case 2:
            allActList.categoria = indexPath.row
            allActList.categoriaName = categorias[indexPath.row]
        case 3:
            allActList.categoria = indexPath.row
            allActList.categoriaName = categorias[indexPath.row]
        case 4:
            allActList.categoria = indexPath.row
            allActList.categoriaName = categorias[indexPath.row]
        case 5:
            allActList.categoria = indexPath.row
            allActList.categoriaName = categorias[indexPath.row]
        case 6:
            allActList.categoria = indexPath.row
            allActList.categoriaName = categorias[indexPath.row]
        case 7:
            allActList.categoria = indexPath.row
            allActList.categoriaName = categorias[indexPath.row]
        case 8:
            allActList.categoria = indexPath.row
            allActList.categoriaName = categorias[indexPath.row]
        case 9:
            allActList.categoria = indexPath.row
            allActList.categoriaName = categorias[indexPath.row]
        default:
            print("default")
        }
        
        allActList.weekDayName = self.weekDayName
        navigationController?.pushViewController(allActList, animated: true)
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
