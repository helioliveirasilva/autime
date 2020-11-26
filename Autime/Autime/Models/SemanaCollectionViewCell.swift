//
//  SemanaCollectionViewCell.swift
//  Autime
//
//  Created by Victor Vieira on 26/11/20.
//

import UIKit

class SemanaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    
    var imageName: String!{
        didSet{
            image.image = UIImage(named: imageName)
        }
    }
}