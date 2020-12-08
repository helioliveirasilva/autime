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
    @IBOutlet weak var happyButton: UIButton!
    @IBOutlet weak var cheerfulButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    var emotion: String! = ""

    func commonInit(){
        
        Bundle.main.loadNibNamed("FeedbackChild", owner: self, options: nil)
        self.addSubview(contentView)
        
        self.popUpView.layer.cornerRadius = 16
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
            }
            else {
                print("Sem emoção.")
            }
        }
        
    }
    
    func congratsScreen() {
        guard let parent: UIViewController = self.parentViewController else {
            return
        }
        
        parent.dismiss(animated: true, completion: nil)
    }
}

extension UIResponder {
    public var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
