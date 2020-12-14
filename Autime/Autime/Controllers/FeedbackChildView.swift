//
//  FeedbackChildView.swift
//  Autime
//
//  Created by Matheus Andrade on 07/12/20.
//

import UIKit

class FeedbackChildView: UIView {
    // Feedback
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var upsetButton: UIButton!
    @IBOutlet weak var sadButton: UIButton!
    @IBOutlet weak var happyButton: UIButton!
    @IBOutlet weak var cheerfulButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    @IBOutlet weak var chateadoLabel: UILabel!
    @IBOutlet weak var tristeLabel: UILabel!
    @IBOutlet weak var felizLabel: UILabel!
    @IBOutlet weak var alegreLabel: UILabel!
    // Congratulations
    @IBOutlet weak var congratsView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var outButton: UIButton!
    @IBOutlet weak var concluiuLabel: UILabel!
    
    var emotion: String! = ""

    func commonInit() {
        
        Bundle.main.loadNibNamed("FeedbackChild", owner: self, options: nil)
        
        // Mudar fontes e arredondamentos
        self.tituloLabel.font = .rounded(ofSize: 25, weight: .bold)
        self.chateadoLabel.font = .rounded(ofSize: 13, weight: .bold)
        self.tristeLabel.font = .rounded(ofSize: 13, weight: .bold)
        self.felizLabel.font = .rounded(ofSize: 13, weight: .bold)
        self.alegreLabel.font = .rounded(ofSize: 13, weight: .bold)
        self.continueButton.titleLabel?.font = .rounded(ofSize: 15, weight: .bold)
        self.skipButton.titleLabel?.font = .rounded(ofSize: 14, weight: .medium)
        
            // Agora da tela parabéns
        self.nextButton.titleLabel?.font = .rounded(ofSize: 15, weight: .bold)
        self.outButton.titleLabel?.font = .rounded(ofSize: 14, weight: .medium)
        self.concluiuLabel.font = .rounded(ofSize: 17, weight: .medium)
        self.nextButton.layer.cornerRadius = nextButton.layer.bounds.height/2
        
        
        self.addSubview(contentView)
        self.addSubview(congratsView)
        self.congratsView.isHidden = true
        self.popUpView.layer.cornerRadius = 16
        self.continueButton.layer.cornerRadius = continueButton.layer.bounds.height/2
        self.congratsView.layer.cornerRadius = 16
        self.upsetButton.layer.cornerRadius = self.upsetButton.bounds.width/4
        self.sadButton.layer.cornerRadius = self.sadButton.bounds.width/4
        self.happyButton.layer.cornerRadius = self.happyButton.bounds.width/4
        self.cheerfulButton.layer.cornerRadius = self.cheerfulButton.bounds.width/4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    @IBAction func emotionTap(_ sender: UIButton) {

        upsetButton.backgroundColor = .clear
        sadButton.backgroundColor = .clear
        happyButton.backgroundColor = .clear
        cheerfulButton.backgroundColor = .clear
        
        sender.backgroundColor = #colorLiteral(red: 0.5725490196, green: 0.8156862745, blue: 0.4196078431, alpha: 1)
        
        if sender == upsetButton {
            // do something
            self.emotion = "upset"
        } else if sender == sadButton {
            // do something
            self.emotion = "sad"
        } else if sender == happyButton {
            // do something
            self.emotion = "happy"
        } else if sender == cheerfulButton {
            // do something
            self.emotion = "cheerful"
        } else {
            print("Foi bug, papai...")
        }
    }
    
    @IBAction func continueOrSkipTap(_ sender: UIButton) {
        
        if sender == skipButton {
            self.congratsScreen()
        } else {
            
            if emotion != "" {
                self.congratsScreen()
            } else {
                print("Sem emoção.")
            }
        }
    }
    
    @IBAction func nextOrOutTap(_ sender: Any) {
        self.dismissCard()
    }
    
    func congratsScreen() {
        self.congratsView.isHidden = false
    }
    
    func dismissCard() {
        guard let parent: UIViewController = self.parentViewController else {
            return
        }
        parent.dismiss(animated: true, completion: nil)
    }
}
