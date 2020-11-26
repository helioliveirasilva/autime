//
//  SectionHeaderView.swift
//  Autime
//
//  Created by Victor Vieira on 26/11/20.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var data: UILabel!
    
    var dataText: String!{
        didSet{
            data.text = dataText
        }
    }
}
