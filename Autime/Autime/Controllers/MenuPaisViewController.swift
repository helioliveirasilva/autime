//
//  File.swift
//  Autime
//
//  Created by Luis Eduardo Ramos on 23/11/20.
//

import UIKit

class MenuPaisViewController: UIViewController {
    //Variables
    let viewThisWeek = UIStoryboard(name: "PaisThisWeek", bundle: nil).instantiateViewController(withIdentifier: "ThisWeeksPaisViewController") as? ThisWeeksPaisViewController
    let viewPastWeeks = UIStoryboard(name: "PaisPastWeeks", bundle: nil).instantiateViewController(withIdentifier: "PastWeeksPaisViewController") as? PastWeeksPaisViewController

    //ActionSheet
    @IBAction func displayActionSheet(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: "Qual Semana?", preferredStyle: .actionSheet)
        //This Week
        let thisWeekAction = UIAlertAction(title: "Semana Atual", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Seman Atual")
            
            self.navigationController?.pushViewController(self.viewThisWeek ?? ThisWeeksPaisViewController(), animated: true)
        })
        //Past Week
        let pastWeekAction = UIAlertAction(title: "Semanas Anteriores", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Semanas Anteriores")
            self.navigationController?.pushViewController(self.viewPastWeeks ?? PastWeeksPaisViewController(), animated: true)
        })
        //Cancel Button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Canceled")
        })
        //Add actions on Action Sheet
        optionMenu.addAction(thisWeekAction)
        optionMenu.addAction(pastWeekAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)

        //   self.navigationController?.navigationBar.isHidden = true



    }

}
