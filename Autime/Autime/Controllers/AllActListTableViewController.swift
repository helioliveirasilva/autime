//
//  AllActListTableViewController.swift
//  Autime
//
//  Created by Luis Eduardo Ramos on 27/11/20.
//
// swiftlint:disable trailing_whitespace
// swiftlint:disable vertical_whitespace

import UIKit

class AllActListTableViewController: UITableViewController {
    //Variables
    var categoria: Int?
    var categoriaName: String?
    var info = [["Comer", "Dormir"], ["Escola", "Terapia"], ["Em Breve"], ["Em Breve"], ["Em Breve"], ["Em Breve"], ["Em Breve"], ["Em Breve"], ["Em Breve"], ["Em Breve"]]
    //MARK:- Garantir que a TV carregue a info do banco de dados
//    var info = 0 {
//        didSet {
//            tableView.reloadData()
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = categoriaName
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let categoria = categoria else {
            return 0
        }
        return info[categoria].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "actCell", for: indexPath)

        guard let categoria = categoria else {
            //Retornar célula vazia
            return UITableViewCell()
        }
        // Configure the cell...
        cell.textLabel?.text = info[categoria][indexPath.row]
        cell.textLabel?.font = .rounded(ofSize: 17, weight: .regular)

        return cell
    }
    
    //Selection
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let allActFocus = storyboard?.instantiateViewController(identifier: "AllActFocusViewController") as? AllActFocusViewController else {
            return
        }
        allActFocus.actNameInfo = info[categoria ?? 0][indexPath.row]
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

