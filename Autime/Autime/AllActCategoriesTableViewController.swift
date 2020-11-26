//
//  AllActCategoriesTableViewController.swift
//  Autime
//
//  Created by Luis Eduardo Ramos on 24/11/20.
//

import UIKit

class AllActPaisViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    //Variables
    var categorias: [String] = ["Domésticas", "Higiene", "Educação", "Saúde", "Família", "Amigos", "Alimentação", "Entreterimento", "Prêmio", "Extras"]
    var catImages: [String] = ["CatDomestic", "CatHygiene", "CatEducation", "CatHealth", "CatFamily", "CatFriends", "CatFood", "CatEntertainment", "CatPrize", "CatExtras"]
   //ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .secondarySystemBackground
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source
    //Header TableView
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "CATEGORIAS"
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
        return 1
    }
    //Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categorias.count
    }
    //Cell Config
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = String(categorias[indexPath.row])
        cell.imageView?.image = UIImage(named: catImages[indexPath.row])
        return cell
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
