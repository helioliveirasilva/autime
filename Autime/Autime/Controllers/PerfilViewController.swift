//
//  PerfilViewController.swift
//  Autime
//
//  Created by Luis Eduardo Ramos on 01/12/20.
//

import UIKit

class PerfilViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var whoRULabel: UILabel!
    @IBOutlet weak var childButton: UIButton!
    @IBOutlet weak var parentButton: UIButton!
    @IBOutlet weak var childLabel: UILabel!
    @IBOutlet weak var parentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .systemGray2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //NavBar
        navigationController?.navigationBar.barStyle = .black
        navigationController?.isNavigationBarHidden = true
        
        //View
        popupView.layer.cornerRadius = 21
        popupView.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        popupView.layer.shadowOpacity = 0.15
        popupView.layer.shadowRadius = 30.0
        popupView.backgroundColor = .white
        
        //Labels
        whoRULabel.font = .rounded(ofSize: 25, weight: .bold)
        parentLabel.font = .rounded(ofSize: 18, weight: .bold)
        childLabel.font = .rounded(ofSize: 18, weight: .bold)
        parentLabel.textColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
        childLabel.textColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
