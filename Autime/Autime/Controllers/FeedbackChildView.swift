//
//  FeedbackChildView.swift
//  Autime
//
//  Created by Matheus Andrade on 07/12/20.
//

import UIKit


class FeedbackChildView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var upsetButton: UIButton!
    @IBOutlet weak var sadButton: UIButton!
    @IBOutlet weak var angryButton: UIButton!
    @IBOutlet weak var happyButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!

    func commonInit(){
        
        Bundle.main.loadNibNamed("FeedbackChild", owner: self, options: nil)
        self.addSubview(contentView)
        
        self.popUpView.layer.cornerRadius = 16
        self.upsetButton.layer.cornerRadius = self.upsetButton.bounds.width/4
        self.sadButton.layer.cornerRadius = self.sadButton.bounds.width/4
        self.angryButton.layer.cornerRadius = self.angryButton.bounds.width/4
        self.happyButton.layer.cornerRadius = self.happyButton.bounds.width/4

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
        angryButton.backgroundColor = .clear
        happyButton.backgroundColor = .clear
        
        sender.backgroundColor = #colorLiteral(red: 0.5725490196, green: 0.8156862745, blue: 0.4196078431, alpha: 1)
        
        if sender == upsetButton {
            // do something
        } else if sender == sadButton {
            // do something
        } else if sender == angryButton {
            // do something
        } else if sender == happyButton {
            // do something
        } else {
            print("Foi bug, papai...")
        }
    }
}
