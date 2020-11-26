//
//  DiaFilhoViewController.swift
//  Autime
//
//  Created by Victor Vieira on 19/11/20.
//

import UIKit

class DiaFilhoViewController: UIViewController {
    
    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var weekView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    @IBAction func switchView(_ segment: UISegmentedControl){
        if segment.selectedSegmentIndex == 0 {
            dayView.isHidden = false
            weekView.isHidden = true
        }
        else{
            dayView.isHidden = true
            weekView.isHidden = false
        }
    }
}

