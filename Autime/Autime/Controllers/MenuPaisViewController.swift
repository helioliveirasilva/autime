//
//  File.swift
//  Autime
//
//  Created by Luis Eduardo Ramos on 23/11/20.
//

import UIKit

class MenuPaisViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var viewNavBar: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var allActButton: UIButton!
    @IBOutlet weak var creatActButton: UIButton!
    @IBOutlet weak var weeksButton: UIButton!
    @IBOutlet weak var tutorialButton: UIButton!
    
    //Variables
    let viewThisWeek = UIStoryboard(name: "PaisThisWeek", bundle: nil).instantiateViewController(withIdentifier: "ThisWeeksPaisViewController") as? ThisWeeksPaisViewController
    let viewPastWeeks = UIStoryboard(name: "PaisPastWeeks", bundle: nil).instantiateViewController(withIdentifier: "PastWeeksPaisViewController") as? PastWeeksPaisViewController
    
    //ActionSheet
    @IBAction func displayActionSheet(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: "Qual Semana?", preferredStyle: .actionSheet)
        //This Week
        let thisWeekAction = UIAlertAction(title: "Semana Atual", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
//            print("Seman Atual")
            self.navigationController?.pushViewController(self.viewThisWeek ?? ThisWeeksPaisViewController(), animated: true)
        })
        //Past Week
        let pastWeekAction = UIAlertAction(title: "Semanas Anteriores", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
//            print("Semanas Anteriores")
            self.navigationController?.pushViewController(self.viewPastWeeks ?? PastWeeksPaisViewController(), animated: true)
        })
        //Cancel Button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
//            print("Canceled")
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
    override func viewWillAppear(_ animated: Bool) {
        //View
        self.view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        //NavBar
        navigationController?.navigationBar.setBackgroundImage(#colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1).image(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
        navigationController?.isNavigationBarHidden = true
        
        //FakeNavBar
        self.viewNavBar.layer.cornerRadius = 21
        viewNavBar.layer.shadowColor = UIColor.black.cgColor
        viewNavBar.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        viewNavBar.layer.shadowOpacity = 0.5
        viewNavBar.layer.shadowRadius = 4.0
        
        //Label
        titleLabel.font = .rounded(ofSize: 25, weight: .bold)
        
        //Buttons
        allActButton.layer.cornerRadius = 19
        allActButton.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        allActButton.layer.shadowOpacity = 0.15
        allActButton.layer.shadowRadius = 30.0
        
        creatActButton.layer.cornerRadius = 19
        creatActButton.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        creatActButton.layer.shadowOpacity = 0.15
        creatActButton.layer.shadowRadius = 30.0
        
        weeksButton.layer.cornerRadius = 19
        weeksButton.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        weeksButton.layer.shadowOpacity = 0.15
        weeksButton.layer.shadowRadius = 30.0
        
        tutorialButton.layer.cornerRadius = 19
        tutorialButton.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        tutorialButton.layer.shadowOpacity = 0.15
        tutorialButton.layer.shadowRadius = 30.0
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
