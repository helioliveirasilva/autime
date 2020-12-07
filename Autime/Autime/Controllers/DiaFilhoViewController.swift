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
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var changeProfileView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // View Geral
        self.navigationView.layer.cornerRadius = 21
        
        // Data e hora
        let hour = DateFormatter()
        hour.dateFormat = "hh:mm"
        
        let date = DateFormatter()
        date.dateFormat = "EEEE, dd/MM"
        date.locale = Locale(identifier: "pt_BR")
        
        
        
        
        //Labels
        dayLabel.font = .rounded(ofSize: 20, weight: .black)
        hourLabel.font = .rounded(ofSize: 25, weight: .bold)
        hourLabel.text = hour.string(from: Date())
        dayLabel.text = date.string(from: Date())
        
        // Botão Trocar de Perfil
        self.changeProfileView.layer.cornerRadius = 21
        
        
        
        
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



extension UIFont {
    class func rounded(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size, weight: weight)
        let font: UIFont
        
        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: descriptor, size: size)
        } else {
            font = systemFont
        }
        return font
    }
}
