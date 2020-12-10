//
//  AddSubAtividadeView.swift
//  Autime
//
//  Created by Victor Vieira on 09/12/20.
//

import UIKit

class AddSubAtividadeView: UIView {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var textfield: UITextField!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func commomInit(){
        Bundle.main.loadNibNamed("AddSubAtividade", owner: self, options: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commomInit()
    }
    
    
    
}

