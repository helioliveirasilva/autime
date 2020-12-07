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
            
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

}
