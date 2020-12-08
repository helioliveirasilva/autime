//
//  TutorialViewController.swift
//  Autime
//
//  Created by Luis Eduardo Ramos on 01/12/20.
//

import UIKit

class TutorialViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var viewFakeBar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        //FakeNavBar
        self.viewFakeBar.layer.cornerRadius = 21
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
